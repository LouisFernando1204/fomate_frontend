part of 'model.dart';

class Schedule extends Equatable {
  final String? id;
  final String? userId;
  final String? appName;
  final String? startTime;
  final String? endTime;
  final int? timer;

  const Schedule({
    this.id,
    this.userId,
    this.appName,
    this.startTime,
    this.endTime,
    this.timer,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        appName: json['appName'] as String?,
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        timer: json['timer'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'appName': appName,
        'startTime': startTime,
        'endTime': endTime,
        'timer': timer,
      };

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      appName,
      startTime,
      endTime,
      timer,
    ];
  }
}
