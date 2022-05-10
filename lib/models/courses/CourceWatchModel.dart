
class CourseWatchModel{
dynamic  can_finish_course;
dynamic title;
dynamic status;
dynamic linkvideo=[];
dynamic links;
dynamic linkPdf=[];
dynamic list=[];
dynamic index;


CourseWatchModel({required this.can_finish_course,required this.title,required this.status,required this.links});

  factory CourseWatchModel.fromJson(Map<String, dynamic> json) {
    return CourseWatchModel(
        title: json['assigned']['title'],
        can_finish_course: json['can_finish_course'],
        status: json['results']['status'],
      links: json['content'],

    );
  }
 void getLinkVideos(String link){
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    print(link);
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    List<String> r= link.split("www.youtube.com/embed/");
    print(r.length);
    for(int i=1;i<r.length;i++){
      int index=r[i].indexOf('"');

      r[i]=r[i].substring(0,index);
      if(r[i].contains('list')){



         index=r[i].indexOf('?list');
         list.add(r[i].substring(index));
         r[i]=r[i].substring(0,index);

      }

    }

    this.linkvideo=r;

  }
void getLinkPdfs(String link) {

  List<String> li= link.split('href="');
  int i=1;

  for(i;i<li.length;i++){
    var index=li[i].indexOf('.pdf');
    li[i]=li[i].substring(0,index+4);


print(li[i]);

  }
  if(i==li.length){
    if(li[i-1].contains('embeddoc'))
    {
      li.removeLast();
    }
  }


  this.linkPdf=li;
}

}