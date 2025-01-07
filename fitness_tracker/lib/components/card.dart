import 'dart:developer';

import 'package:fitness_tracker/exercise.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final Exercise exercise;

  const CardItem({super.key, required this.exercise});

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardItem> {
  bool _readMoreExpanded = false;

  @override
  Widget build(BuildContext context) {
    String instructionsText = widget.exercise.instructions.join('\n');
    String imagePathPre = "assets/exercises/${widget.exercise.images[0]}";
    // String imagePathPost = "assets/exercises/${widget.exercise.images[1]}";

    // String imagePathPre = "assets/exercises/3_4_Sit-Up/0.jpg";
    log(imagePathPre);

    return Padding(
        padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Card(
          child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 150.0, // Minimum height for the card
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: widget.exercise.images.isNotEmpty
                          ? Container(
                              height: 100, // Adjust height as needed
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  imagePathPre,
                                  width: 100, // Adjust width as needed
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : Container(
                              alignment: Alignment.center,
                              height: 100, // Match the height for consistency
                              width: 100, // Match the width for consistency
                              child: const Text(
                                'No image',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                      title: Text(widget.exercise.name),
                      subtitle: AnimatedCrossFade(
                        firstChild: Text(
                          instructionsText,
                          maxLines: 3, // Show only 3 lines initially
                          overflow: TextOverflow
                              .ellipsis, // Add ellipsis if text overflows
                          style: TextStyle(fontSize: 14),
                        ),
                        secondChild: Text(
                          instructionsText,
                          style: TextStyle(fontSize: 14),
                        ),
                        crossFadeState: _readMoreExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 100),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _readMoreExpanded = !_readMoreExpanded;
                            });
                          },
                          child: Text(
                              _readMoreExpanded ? 'Show Less' : 'Show More'),
                        ),
                        TextButton(
                          child: const Text('BUY TICKETS'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('LISTEN'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
