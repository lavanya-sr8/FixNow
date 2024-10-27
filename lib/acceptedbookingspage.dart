// AcceptedBookingsPage.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptedBookingsPage extends StatefulWidget {
  final String userId;

   AcceptedBookingsPage({Key? key, required this.userId}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Ensure Firestore is initialized
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
            .where('status', isEqualTo: 'Accepted')
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
              return Card(
      elevation: 4, // Adds shadow to the card
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Space around each card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Handyman: $handymanName",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Space between the name and details
            Text(
              "Date: $formattedDate",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700], // Slightly lighter grey
              ),
            ),
            Text(
              "Time: $formattedTime",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            Text(
              "Status: $bookingStatus",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: bookingStatus == 'Confirmed' ? Colors.green : Colors.red, // Color based on status
              ),
            ),
            SizedBox(height: 16), // Space before the button
            ElevatedButton(
              onPressed: () async {
                // Call the function to update the booking status to "Finished"
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              child: Text(
                "Finished",
                style: TextStyle(color: Colors.white), // Button text color
              ),
            ),
          ],
        ),
      ),
    );
  }).toList(),
);
},
      ),
    );
  }
}


  