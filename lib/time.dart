import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulePage extends StatefulWidget {
  final String handymanId;
  final String handymanName;
  final int handymanExperience; // Add handyman experience
  final String selectedService;
  final String clientId; // Assuming you have a client ID passed to the page
  
  const SchedulePage({
    super.key,
    required this.handymanId,
    required this.handymanName,
    required this.handymanExperience,
    required this.selectedService,
    required this.clientId, // Added client ID
  });

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;
  String? selectedTimeSlot;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add the sendNotification function here
 

  Future<void> bookAppointment() async {
    if (selectedDate != null && selectedTimeSlot != null) {
      // Combine date and selected time slot into a single DateTime object
      DateTime bookingTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        int.parse(selectedTimeSlot!.split(':')[0]), // Get hour from time slot
      );

      try {
        // Create a new document reference with auto-generated ID
      DocumentReference bookingRef = _firestore.collection('bookings').doc();
        // Add the booking details to Firestore, including the bookingId
      await bookingRef.set({
        'bookingId': bookingRef.id, // Use the document ID as the booking ID
        'clientId': widget.clientId, // Include client ID
        'handymanId': widget.handymanId, // Assuming handyman has an ID property
        'bookingTime': bookingTime.toIso8601String(), // Store as ISO string
        'status': 'Pending', // Set initial status
        // Include other details if needed
        'service': widget.selectedService,
        'handymanName': widget.handymanName,
        'experience': widget.handymanExperience,
        'bookedAt': DateTime.now(),
      });

      

        // Show a confirmation dialog
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Booking Confirmed'),
            content: Text(
                'Your booking for ${bookingTime.toLocal()} has been confirmed.'),
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
        const SnackBar(
            content: Text('Please select a date and time slot first.')),
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
              onPressed: () {
                bookAppointment().then((_) {
                  // Optional: Additional logic after booking
                  // You could navigate back or show a different message
                });
              }, // Call the function to save the booking
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