class AgentQRCodeModel {
  int? status;
  Data? data;

  AgentQRCodeModel({this.status, this.data});

  AgentQRCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? qrCode;
  String? encAgentId;
  int? agentId;
  String? firstName;
  String? lastName;

  Data(
      {this.qrCode,
        this.encAgentId,
        this.agentId,
        this.firstName,
        this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    qrCode = json['qr_code'];
    encAgentId = json['enc_agent_id'];
    agentId = json['agent_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qr_code'] = this.qrCode;
    data['enc_agent_id'] = this.encAgentId;
    data['agent_id'] = this.agentId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}