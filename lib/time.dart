import 'package:FixNow/handyman_bookings.dart';
import 'package:flutter/material.dart';
import 'package:FixNow/service_selection_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulePage extends StatefulWidget {
  final Handyman handyman;
  final String selectedService;

  const SchedulePage({super.key, required this.handyman, required this.selectedService});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> bookAppointment() async {
    if (selectedDate != null && selectedTimeSlot != null) {
      final String date = selectedDate!.toString().split(' ')[0];
      final String timeSlot = selectedTimeSlot!;

      try {
        // Add the booking details to Firestore
        await _firestore.collection('bookings').add({
          'handymanName': widget.handyman.name,
          'service': widget.selectedService,
          'rating': widget.handyman.rating,
          'experience': widget.handyman.experience,
          'imageUrl': widget.handyman.imageUrl,
          'date': date,
          'timeSlot': timeSlot,
          'bookedAt': DateTime.now(),
        });

        // Show a confirmation dialog
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Booking Confirmed'),
            content: Text('Your booking for $date at $timeSlot has been confirmed.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      } catch (error) {
        print('Failed to book appointment: $error');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time slot first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Appointment'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Select Date: ${selectedDate?.toString().split(' ')[0] ?? 'Not selected'}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.0,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                int hour = 7 + index; // From 7 AM to 7 PM
                return Card(
                  margin: const EdgeInsets.all(4.0),
                  color: Colors.blue[100],
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = '$hour:00';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Time slot selected: $hour:00'),
                        ),
                      );
                    },
                    child: Center(child: Text('$hour:00')),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: bookAppointment, // Call the function to save the booking
              child: const Text('Book Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class _SchedulePageState extends State<SchedulePage> {
//   DateTime? selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule Appointment'),
//       ),
//       body: Column(
//         children: [
//           ListTile(
//             title: Text(
//               'Select Date: ${selectedDate?.toString().split(' ')[0] ?? 'Not selected'}',
//             ),
//             trailing: Icon(Icons.calendar_today),
//             onTap: () async {
//               DateTime? picked = await showDatePicker(
//                 context: context,
//                 initialDate: selectedDate ?? DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//               );
//               if (picked != null) {
//                 setState(() {
//                   selectedDate = picked;
//                 });
//               }
//             },
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 2.0,
//               ),
//               itemCount: 12,
//               itemBuilder: (BuildContext context, int index) {
//                 int hour = 7 + index;
//                 return Card(
//                   margin: EdgeInsets.all(4.0),
//                   color: Colors.blue[100],
//                   child: InkWell(
//                     onTap: () {
//                       print('Tapped on time slot $hour:00');
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('Tapped on $hour:00'),
//                       ));
//                     },
//                     child: Center(
//                       child: Text('$hour:00'),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const Notifications()),
//                     );
//                 if (selectedDate != null) {
//                   print('Booking confirmed for $selectedDate');
//                   showDialog(
//                     context: context,
//                     builder: (ctx) => AlertDialog(
//                       title: Text('Request Submitted'),
//                       content: Text(
//                         'Your booking for ${selectedDate?.toString().split(' ')[0]} has been submitted to the handyman.',
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () => Navigator.of(ctx).pop(),
//                           child: Text('Okay'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('Please select a date first.'),
//                   ));
//                 }
//               },
//               child: Text('Book Now',
//               style: TextStyle(color: Colors.white),),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF00B4D8),

//                 minimumSize: Size(double.infinity, 50),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }