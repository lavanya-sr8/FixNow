import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandymanDashboard extends StatefulWidget {
  const HandymanDashboard({Key? key}) : super(key: key);

  @override
  State<HandymanDashboard> createState() => _HandymanDashboardState();
}

class _HandymanDashboardState extends State<HandymanDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Real-time stream to fetch pending bookings for the current handyman
  Stream<QuerySnapshot> fetchPendingBookings() {
    User? user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty(); // Return empty stream if no user
    }

    // Listen to real-time changes in the bookings collection
    return _firestore
        .collection('Bookings')
        .where('handymanId', isEqualTo: user.uid) // Match logged-in handyman
        .where('status', isEqualTo: 'Pending')   // Only fetch pending bookings
        .snapshots();
  }

  // Handle booking acceptance
  Future<void> acceptBooking(String bookingId) async {
    await _firestore.collection('Bookings').doc(bookingId).update({
      'status': 'Accepted',
    });
  }

  // Handle booking rejection
  Future<void> rejectBooking(String bookingId) async {
    await _firestore.collection('Bookings').doc(bookingId).update({
      'status': 'Rejected',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handyman Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fetchPendingBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending bookings.'));
          }

          List<QueryDocumentSnapshot> bookings = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                var booking = bookings[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Client ID: ${booking['clientId']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Service: ${booking['service']}'),
                        const SizedBox(height: 4),
                        Text('Booking Time: ${booking['bookingTime'].toDate().toString()}'), // Convert Timestamp to DateTime
                        const SizedBox(height: 4),
                        Text('Handyman: ${booking['handymanName'] ?? 'N/A'}'), // Ensure handyman name exists
                        const SizedBox(height: 4),
                        Text('Experience: ${booking['experience']?.toString() ?? 'N/A'} years'), // Ensure experience exists
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                acceptBooking(bookings[index].id); // Use booking ID
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Accept'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                rejectBooking(bookings[index].id); // Use booking ID
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Reject'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
