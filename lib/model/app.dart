part of 'model.dart';

class App extends Equatable {
  final String? id;
  final String? appName;

  const App({this.id, this.appName});

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json['id'] as String?,
        appName: json['appName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'appName': appName,
      };

  @override
  List<Object?> get props => [id, appName];
}
