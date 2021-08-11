class Message {
  final String sender;
  final String msg;

  Message({
    required this.sender,
    required this.msg,
  });

  Message.fromJson(Map<String, dynamic> json)
      : sender = json['sender'],
        msg = json['msg'];

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'msg': msg,
      };
}
