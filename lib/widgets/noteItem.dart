import 'package:flutter/material.dart';
import 'package:notic_app/constant.dart';
import 'package:notic_app/models/note_model.dart';

class NoteItem extends StatelessWidget {
 final NoteModel? notemodel ;
 final Function() delete;
 final Function() edite;

  const NoteItem({super.key,required this.notemodel, required this.delete, required this.edite});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 16 ,top: 24,bottom: 24),
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(16)),
      child:
       Row(
        children: [
         Image.network(
            "$linkImageRoot/${notemodel!.imageNmae}",
            width: 100,
            height: 150,
          ),
          Expanded(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListTile(
                  title: Text("${notemodel!.nTitle}" ,style: TextStyle
                  (color: Colors.black,
                  fontSize: 30,
                  ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '${notemodel!.nContent}',style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 15
                        ),),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: delete
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: edite
                      ),
                    ],
                  ),
                ),
             Padding(
               padding: const EdgeInsets.only(right: 24),
               child: Text("May21 , 2022", style: TextStyle(color: Colors.black.withOpacity(.5)),),
             )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
