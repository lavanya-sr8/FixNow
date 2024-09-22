import 'package:flutter/material.dart';

class Service {
  final IconData icon;
  final String title;
  final String description;

  Service({required this.icon, required this.title, required this.description});
}

class Handyman {
  final String name;
  final String experience;
  final double rating;
  final String imageUrl;
  final List<String> services;

  const Handyman({
    required this.name,
    required this.experience,
    required this.rating,
    required this.imageUrl,
    required this.services,
  });
}

class ServiceSelectionPage extends StatelessWidget {
  const ServiceSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      Service(
        icon: Icons.plumbing,
        title: 'Plumbing',
        description: 'Expert plumbing services for all your needs.',
      ),
      Service(
        icon: Icons.power_settings_new,
        title: 'Electrical',
        description: 'Reliable electrical work for your home or business.',
      ),
      Service(
        icon: Icons.brush,
        title: 'Painting',
        description: 'Professional painting services for interior and exterior.',
      ),
      Service(
        icon: Icons.handyman,
        title: 'General Handyman',
        description: 'A variety of handyman services for your home or business.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FixNow!', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            icon: service.icon,
            title: service.title,
            description: service.description,
          );
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48.0),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(description, style: const TextStyle(fontSize: 12.0)),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to handyman listing page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HandymanListPage(selectedService: title),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Select'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HandymanListPage extends StatefulWidget {
  final String selectedService;

  const HandymanListPage({super.key, required this.selectedService});

  @override
  State<HandymanListPage> createState() => _HandymanListPageState();
}

class _HandymanListPageState extends State<HandymanListPage> {
  final List<Handyman> handymen = [
    Handyman(
      name: 'John Smith',
      experience: '5 years',
      rating: 4.8,
      imageUrl: 'assets/handyman1.jpg',
      services: ['Plumbing', 'Electrical','Painting'],
    ),
    Handyman(
      name: 'Jane Doe',
      experience: '3 years',
      rating: 4.5,
      imageUrl: 'assets/handyman2.jpg',
      services: ['Carpentry', 'Painting','Plumbing','Electrical'],
    ),
    Handyman(
      name: 'Person 3',
      experience: '2 years',
      rating: 4.2,
      imageUrl: 'assets/handyman3.jpg',
      services: ['Plumbing', 'Painting','Electrical'],
    ),
    Handyman(
      name: 'Person 4',
      experience: '4 years',
      rating: 4.7,
      imageUrl: 'assets/handyman4.jpg',
      services: ['Electrical', 'Carpentry','Plumbing'],
    ),
    // Add more handymen as needed
  ];

  @override
  Widget build(BuildContext context) {
    final filteredHandymen = handymen.where((handyman) =>
        handyman.services.contains(widget.selectedService)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Handymen for ${widget.selectedService}'),
      ),
      body: ListView.builder(
        itemCount: filteredHandymen.length,
        itemBuilder: (context, index) {
          final handyman = filteredHandymen[index];
          return HandymanCard(handyman: handyman);
        },
      ),
    );
  }
}

class HandymanCard extends StatelessWidget {
  final Handyman handyman;

  const HandymanCard({super.key, required this.handyman});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(handyman.imageUrl),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    handyman.name,
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(
                        handyman.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '(${handyman.experience} years exp.)',
                        style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Services: ${handyman.services.join(', ')}',
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement booking logic or navigate to booking page
               
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Set the button color to blue
                foregroundColor: Colors.white, // Set the text color to white
              ),
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}