import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../../../utils/dialog_utilits.dart';
import '../../../../utils/navigation.dart';
import '../../../../widgets/app_bar/head_appbar.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/scaffold/scaffold_f.dart';
import '../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../payment/presentation/views/payment_policy.dart';
import '../widgets/date.dart';
import '../widgets/seats_grid.dart';
import '../widgets/seats_type.dart';
import '../widgets/time.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({super.key, required this.cinemaId, required this.movie});

  final String cinemaId;

  final MoviesDetailsModel movie;
  @override
  _SelectSeatState createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  num _totalPrice = 0;
  List<Map<String, dynamic>> timesList = [];
  List<String> dates = [];
  List<int> days = [];
  List<int> months = [];
  String _seatCategory = '';
  String _highestSeatCategory = '';
  String? _selectedDate;
  String? _selectedHall;

  int? _selectedDay;
  List<Map<String, dynamic>> filteredTimes = [];
  String? _selectedTime;
  List<String> reservedSeats = [];
  List<String> halls = [];

  @override
  void initState() {
    super.initState();
    // _fetchMovieTimes("Point 90 Cinema", "The Dark Knight");
    _fetchMovieTimes(widget.cinemaId, widget.movie.name.toString());
  }

  void _updateTotalPrice(int priceChange) {
    setState(() {
      _totalPrice += priceChange;
    });
  }

  void _updateSeatCategory(int row) {
    setState(() {
      if (row < 2) {
        _seatCategory = "VIP";
      } else if (row < 4) {
        _seatCategory = "Premium";
      } else {
        _seatCategory = "Standard";
      }
    });
  }

  Future<void> _fetchMovieTimes(String cinemaId, String movieName) async {
    try {
      var docSnapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaId)
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? cinemaData = docSnapshot.data();

        if (cinemaData != null && cinemaData.containsKey('movies')) {
          List<dynamic> moviesList = List.from(cinemaData['movies']);

          var selectedMovie = moviesList.firstWhere(
            (movie) => movie['name'] == movieName,
            orElse: () => <String, dynamic>{},
          );

          if (selectedMovie.isNotEmpty) {
            // AppLogs.successLog("Movie '$movieName' found!"); // Removed: was used for logging found movie

            setState(() {
              timesList =
                  List<Map<String, dynamic>>.from(selectedMovie['times']);
              halls = timesList.map((e) => e['hall'].toString()).toList();

              dates = timesList.map((e) => e['date'].toString()).toList();
              days = dates.map((date) => DateTime.parse(date).day).toList();
              months = dates.map((date) => DateTime.parse(date).month).toList();

              if (days.isNotEmpty) {
                _selectedDay = days.first;
                _filterTimesForSelectedDay();
              } else {
                _selectedDay = null;
                filteredTimes = [];
                _selectedTime = null;
                reservedSeats = [];
              }
            });
          } else {
            // print("Movie '$movieName' not found in cinema $cinemaId."); // Removed: was used for debugging missing movie in cinema
          }
        } else {
          // print("No movies found in cinema $cinemaId."); // Removed: was used for debugging missing movies in cinema
        }
      } else {
        // print("No cinema found with ID: $cinemaId"); // Removed: was used for debugging missing cinema
      }
    } catch (e) {
      // print("Error fetching movies data: $e"); // Removed: was used for debugging errors during fetching movies data
    }
  }

  void _filterTimesForSelectedDay() {
    if (_selectedDay != null) {
      setState(() {
        filteredTimes = timesList
            .where((e) => DateTime.parse(e['date']).day == _selectedDay)
            .expand((e) => (e['time'] as List).map((timeData) => {
                  "time": timeData["time"].toString(),
                  "reservedSeats":
                      List<String>.from(timeData["reservedSeats"] ?? [])
                }))
            .toList();

        if (filteredTimes.isNotEmpty) {
          _selectedTime = filteredTimes.first["time"];
          _updateReservedSeats(_selectedTime!);
        } else {
          _selectedTime = null;
          reservedSeats = [];
        }
      });
    } else {
      setState(() {
        filteredTimes = [];
        _selectedTime = null;
        reservedSeats = [];
      });
    }
  }

  void _updateReservedSeats(String selectedTime) {
    var selectedTimeData = filteredTimes.firstWhere(
      (e) => e["time"] == selectedTime,
      orElse: () => <String, Object>{"reservedSeats": <String>[]},
    );

    setState(() {
      reservedSeats =
          List<String>.from(selectedTimeData["reservedSeats"] as List);
    });

    // AppLogs.successLog("Reserved seats for $selectedTime: $reservedSeats"); // Removed: was used for logging reserved seats
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var lang = S.of(context);
    // AppLogs.debugLog(selectedSeats.toString()); // Removed: was used for logging selected seats
    // AppLogs.debugLog(_seatCategory.toString()); // Removed: was used for logging seat category
    // AppLogs.debugLog(_highestSeatCategory.toString()); // Removed: was used for logging highest seat category
    if (selectedSeats.isEmpty) {
      _highestSeatCategory = '';

      _seatCategory = '';
    }

    return ScaffoldF(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => navigatePop(context: context),
        ),
        backgroundColor: theme.primaryColor,
        title: Padding(
          padding: EdgeInsets.only(left: 31.w, bottom: 15.h),
          child: HeadAppBar(title: lang.selectSeat),
        ),
      ),
      body: timesList.isEmpty
          ? const AbsorbPointer(
              absorbing: true,
              child: LoadingIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 333.w,
                    height: 3.h,
                    color: const Color(0xFFF834FC),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/shadwo.png",
                      width: double.infinity,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SeatsGrid(
                    updateTotalPrice: _updateTotalPrice,
                    updateSeatCategory: _updateSeatCategory,
                    reservedSeats: reservedSeats,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SeatsType(
                          color: Theme.of(context)
                              .colorScheme
                              .surface, // available
                          text: lang.available,
                        ),
                        SeatsType(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface, // reserved
                          text: lang.reserved,
                        ),
                        SeatsType(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceVariant, // selected
                          text: lang.selected,
                        ),
                      ]),
                  SizedBox(height: 20.h),
                  Text(
                    _seatCategory.isNotEmpty
                        ? "The selected seat is $_seatCategory"
                        : "No seat selected",
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 15.h),
                  Center(
                    child: Text(
                      lang.selectDateTime,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                  Date(
                    days: days,
                    months: months,
                    years: dates
                        .map((date) => DateTime.parse(date).year)
                        .toList(), // ✅ تمرير السنوات
                    selectedDay: _selectedDay ?? days.first,
                    onDaySelected: (newDay, newMonth, newYear) {
                      // ✅ استقبل السنة أيضًا
                      setState(() {
                        _selectedDay = newDay;
                        _selectedDate =
                            "$newYear-${newMonth.toString().padLeft(2, '0')}-${newDay.toString().padLeft(2, '0')}"; // ✅ تخزين التاريخ بالكامل
                        _filterTimesForSelectedDay();
                        _totalPrice = 0;

                        _highestSeatCategory = '';

                        _seatCategory = '';
                        // AppLogs.successLog("date is $_selectedDate"); // Removed: was used for logging selected date
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  Time(
                    times: filteredTimes,
                    selectedTime: _selectedTime,
                    onTimeSelected: (newTime) {
                      setState(() {
                        _selectedTime = newTime;
                        _updateReservedSeats(newTime);
                        _totalPrice = 0;
                        _highestSeatCategory = '';

                        _seatCategory = '';
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lang.total,
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 20.sp)),
                            Text("$_totalPrice EGP",
                                style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 20.sp,
                                    color: const Color(0xFF09FBD3))),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedSeats.isEmpty) {
                              showCenteredSnackBar(
                                  context, "you have to select seats");
                            } else if (selectedSeats.length > 5) {
                              showCenteredSnackBar(
                                  context, "you cant select more than 5 seats");
                            } else {
                              _getHighestSeatCategory();
                              getHall();

                              navigateTo(
                                  context: context,
                                  screen: PaymentPolicy(
                                      hall: _selectedHall ?? "noHall",
                                      cinemaId: widget.cinemaId,
                                      date: _selectedDate.toString(),
                                      time: _selectedTime ?? "00:00",
                                      model: widget.movie,
                                      seatCategory: _highestSeatCategory,
                                      seats: selectedSeats,
                                      price: _totalPrice,
                                      location: " -"));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF09FBD3),
                            minimumSize: Size(155.w, 42.h),
                          ),
                          child: Text(
                            lang.buyTicket,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontSize: 19.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void getHall() {
    int selectedDateIndex = dates.indexOf(_selectedDate ?? "");
    // AppLogs.debugLog(selectedDateIndex.toString()); // Removed: was used for logging selected date index
    // AppLogs.debugLog(_selectedDate.toString()); // Removed: was used for logging selected date
    // AppLogs.debugLog(halls[selectedDateIndex]); // Removed: was used for logging hall name
    _selectedHall = halls[selectedDateIndex];
  }

  void _getHighestSeatCategory() {
    selectedSeats.sort((a, b) => num.parse(a).compareTo(num.parse(b)));

    num seatNumber = num.parse(selectedSeats[0]);
    // AppLogs.debugLog(selectedSeats.toString()); // Removed: was used for logging selected seats in _getHighestSeatCategory
    // AppLogs.debugLog(seatNumber.toString()); // Removed: was used for logging seat number in _getHighestSeatCategory

    if (seatNumber <= 24) {
      _highestSeatCategory = "VIP";
    } else if (seatNumber <= 48) {
      _highestSeatCategory = "Premium";
    } else {
      _highestSeatCategory = "Standard";
    }
    if (dates.isNotEmpty && _selectedDate == null) {
      DateTime firstDate = DateTime.parse(dates.first);
      _selectedDay = firstDate.day;
      _selectedDate =
          "${firstDate.year}-${firstDate.month.toString().padLeft(2, '0')}-${firstDate.day.toString().padLeft(2, '0')}";
    }
  }
}
