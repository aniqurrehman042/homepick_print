import 'package:flutter/material.dart';
import 'package:homepick_print/providers/home_page_provider.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ISSUED TO',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                onChanged: (value) => context.read<HomePageProvider>().issuedTo = value,
              ),
            ],
          ),
        ),

        SizedBox(width: 20.0),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                onChanged: (value) => context.read<HomePageProvider>().contact = value,
              ),
            ],
          ),
        ),

        SizedBox(width: 20.0),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EMAIL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                onChanged: (value) => context.read<HomePageProvider>().email = value,
              ),
            ],
          ),
        ),

        SizedBox(width: 20.0),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ADDRESS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                onChanged: (value) => context.read<HomePageProvider>().address = value,
              ),
            ],
          ),
        ),
      ],
    );
  }
}