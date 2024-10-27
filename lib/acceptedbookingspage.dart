// AcceptedBookingsPage.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptedBookingsPage extends StatefulWidget {
  final String userId;

  const AcceptedBookingsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _AcceptedBookingsPageState createState() => _AcceptedBookingsPageState();
}

class _AcceptedBookingsPageState extends State<AcceptedBookingsPage> {
  @override
  void initState() {
    super.initState();
    print("Logged in User ID: ${widget.userId}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accepted Bookings"),
        backgroundColor: const Color(0xFF2C3333), // Example color for app bar
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .where('clientId', isEqualTo: widget.userId)
            .where('status', isEqualTo: 'accepted')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("No bookings found for user ID: ${widget.userId}");
            return const Center(child: Text("No accepted bookings found."));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              // Fetch the required fields from the document
              String handymanName = data['handymanName'] ?? 'Unknown Handyman';
             String bookingTimeString = data['bookingTime'] ?? '';
              String bookingStatus = data['status'] ?? 'Unknown Status';

              print("Booking found - Handyman: $handymanName, Client ID: ${data['clientId']}");
             // Parse and format the booking time
              DateTime bookingTime = DateTime.parse(bookingTimeString);
              String formattedDate = "${bookingTime.day}-${bookingTime.month}-${bookingTime.year}";
              String formattedTime = "${bookingTime.hour}:${bookingTime.minute.toString().padLeft(2, '0')}";

              return ListTile(
                title: Text(handymanName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: $formattedDate"),
                    Text("Time: $formattedTime"),
                    Text("Status: $bookingStatus"),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
