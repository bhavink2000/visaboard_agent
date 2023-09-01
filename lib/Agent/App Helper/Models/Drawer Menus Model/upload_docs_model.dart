class UploadDocsModel {
  int status;
  Data data;

  UploadDocsModel({required this.status, required this.data});

  factory UploadDocsModel.fromJson(Map<String, dynamic> json) {
    return UploadDocsModel(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  Map<String, List<Docs>> docs;
  int serviceTypeId;
  int letterTypeId;
  String userId;
  String userSopId;

  Data({
    required this.docs,
    required this.serviceTypeId,
    required this.letterTypeId,
    required this.userId,
    required this.userSopId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final Map<String, List<Docs>> docs = {};
    json['docs'].forEach((key, value) {
      final List<Docs> docsList = [];
      value.forEach((doc) {
        docsList.add(Docs.fromJson(doc));
      });
      docs[key] = docsList;
    });

    return Data(
      docs: docs,
      serviceTypeId: json['service_type_id'],
      letterTypeId: json['letter_type_id'],
      userId: json['user_id'],
      userSopId: json['user_sop_id'],
    );
  }
}

class Docs {
  String documentTitle;
  int serviceTypeDocumentId;
  int isRequired;
  int isUploaded;
  List<dynamic> uploadedDocs;

  Docs({
    required this.documentTitle,
    required this.serviceTypeDocumentId,
    required this.isRequired,
    required this.isUploaded,
    required this.uploadedDocs,
  });

  factory Docs.fromJson(Map<String, dynamic> json) {
    return Docs(
      documentTitle: json['document_title'],
      serviceTypeDocumentId: json['service_type_document_id'],
      isRequired: json['is_required'],
      isUploaded: json['is_uploaded'],
      uploadedDocs: json['uploaded_docs'],
    );
  }
}