
class NoteModel {
  int nId ;
  String nTitle;
  String nContent;
  int nUserId ;
  String imageNmae ;

   NoteModel({
    required this.nId,required this.nContent,
    required this.nTitle,required this.nUserId,required this.imageNmae});
  factory NoteModel.fromjsone(dynamic data)
  {
    return NoteModel(nId: data["n_id"],
    nContent:data["n_content"],
    nTitle: data["n_title"],
    nUserId: data["n_userId"],
    imageNmae:data["imageName"]
    );
  }
}
