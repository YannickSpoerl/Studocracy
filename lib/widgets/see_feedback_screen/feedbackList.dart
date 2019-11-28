import 'dart:async';
import 'package:flutter/material.dart' hide Feedback;
import 'package:studocracy/model/feedback.dart';
import 'package:studocracy/backend/feedback_services.dart';
import 'package:studocracy/style.dart';

class FeedbackList extends StatefulWidget {

  final String lectureId;
  const FeedbackList(this.lectureId);

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  List<Feedback> _feedbackList = List<Feedback>();

  @override
  void initState() {
    super.initState();
    _populateFeedbackList(widget.lectureId);
  }

  void _populateFeedbackList(String lectureId) {
    getFeedbackList(lectureId).then((feedbackList) {
      print("Message: ${_feedbackList[0].message}");
      setState(() => {_feedbackList = feedbackList});
    });
  }

  @override
  Widget build (BuildContext context){
    return ListView.builder(
        itemCount: _feedbackList.length,
        itemBuilder: _buildItemsForListView);
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(_feedbackList[index].message, style: BodyTextStyle),
      trailing: _setIcon(_feedbackList[index].sentiment),
    );
  }

  Icon _setIcon(int sentiment) {
    if (sentiment >= 0 && sentiment < 4) {
      return Icon(Icons.sentiment_very_dissatisfied,
          color: Colors.red, size: 60.0);
    }
    if (sentiment >= 4 && sentiment < 6) {
      return Icon(Icons.sentiment_dissatisfied,
          color: Colors.orange, size: 60.0);
    }
    if (sentiment >= 6 && sentiment < 8) {
      return Icon(Icons.sentiment_satisfied, color: Colors.yellow, size: 60.0);
    }

    return Icon(Icons.sentiment_very_satisfied,
        color: Colors.green, size: 60.0);
  }
}