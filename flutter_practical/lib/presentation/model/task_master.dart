/// Task : [{"TaskDate":"","TaskDescription":"","TaskId":1,"TaskName":"","UserId":""}]

class Task {
  Task({
      List<Task>? task,}){
    _task = task;
}

  Task.fromJson(dynamic json) {
    if (json['Task'] != null) {
      _task = [];
      json['Task'].forEach((v) {
        _task?.add(Task.fromJson(v));
      });
    }
  }
  List<Task>? _task;
Task copyWith({  List<Task>? task,
}) => Task(  task: task ?? _task,
);
  List<Task>? get task => _task;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_task != null) {
      map['Task'] = _task?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// TaskDate : ""
/// TaskDescription : ""
/// TaskId : 1
/// TaskName : ""
/// UserId : ""

class Task {
  Task({
      String? taskDate, 
      String? taskDescription, 
      int? taskId, 
      String? taskName, 
      String? userId,}){
    _taskDate = taskDate;
    _taskDescription = taskDescription;
    _taskId = taskId;
    _taskName = taskName;
    _userId = userId;
}

  Task.fromJson(dynamic json) {
    _taskDate = json['TaskDate'];
    _taskDescription = json['TaskDescription'];
    _taskId = json['TaskId'];
    _taskName = json['TaskName'];
    _userId = json['UserId'];
  }
  String? _taskDate;
  String? _taskDescription;
  int? _taskId;
  String? _taskName;
  String? _userId;
Task copyWith({  String? taskDate,
  String? taskDescription,
  int? taskId,
  String? taskName,
  String? userId,
}) => Task(  taskDate: taskDate ?? _taskDate,
  taskDescription: taskDescription ?? _taskDescription,
  taskId: taskId ?? _taskId,
  taskName: taskName ?? _taskName,
  userId: userId ?? _userId,
);
  String? get taskDate => _taskDate;
  String? get taskDescription => _taskDescription;
  int? get taskId => _taskId;
  String? get taskName => _taskName;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TaskDate'] = _taskDate;
    map['TaskDescription'] = _taskDescription;
    map['TaskId'] = _taskId;
    map['TaskName'] = _taskName;
    map['UserId'] = _userId;
    return map;
  }

}