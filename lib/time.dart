import 'package:FixNow/verify.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Appointment'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Select Date: ${selectedDate?.toString().split(' ')[0] ?? 'Not selected'}',
            ),
            trailing: Icon(Icons.calendar_today),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.0,
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                int hour = 7 + index;
                return Card(
                  margin: EdgeInsets.all(4.0),
                  color: Colors.blue[100],
                  child: InkWell(
                    onTap: () {
                      print('Tapped on time slot $hour:00');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tapped on $hour:00'),
                      ));
                    },
                    child: Center(
                      child: Text('$hour:00'),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Verify()),
                    );
                if (selectedDate != null) {
                  print('Booking confirmed for $selectedDate');
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Request Submitted'),
                      content: Text(
                        'Your booking for ${selectedDate?.toString().split(' ')[0]} has been submitted to the handyman.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text('Okay'),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select a date first.'),
                  ));
                }
              },
              child: Text('Book Now',
              style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4D8),

                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}