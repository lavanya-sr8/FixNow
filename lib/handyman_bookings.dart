import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        automaticallyImplyLeading: true, // Automatically adds back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the current page and go back
          },
        ),
      ),
      body: const Bookings(),
    );
  }
}

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => BookingSet();
}

class BookingSet extends State<Bookings> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double buttonWidth = constraints.maxWidth * 0.4; // Adjust width if needed

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Card 1',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This is the description for Card 1.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Aligns buttons with space between them
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              counter++;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(buttonWidth, 50), // Set button width and height
                            backgroundColor:
                                const Color.fromRGBO(226, 241, 255, 0.643),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(
                                color: Color.fromRGBO(102, 173, 100, 0.965),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              counter--;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(buttonWidth, 50), // Set button width and height
                            backgroundColor:
                                Color.fromRGBO(255, 205, 205, 0.627),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text(
                            'Reject',
                            style: TextStyle(
                                color: Color.fromRGBO(250, 109, 109, 0.965),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
