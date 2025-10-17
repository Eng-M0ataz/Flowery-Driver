class UpdateOrderStateRequest {
  UpdateOrderStateRequest({required this.state});

  final String state;


  Map<String, dynamic> toJson() =>
      {
        "state": state,
      };
}
