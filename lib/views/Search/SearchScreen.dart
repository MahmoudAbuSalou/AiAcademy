import 'package:academy/views/Search/cubit/search_cubit.dart';
import 'package:academy/views/Search/cubit/search_state.dart';
import 'package:academy/views/course_info.dart';
import 'package:academy/views/profile_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../components/components.dart';
import '../../components/const.dart';
import '../../shared/components/components.dart';


// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {

  SearchScreen({Key? key}) : super(key: key);
  TextEditingController search = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late var id;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar:  PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: SafeArea(
                child: Container(
                  width: width,
                  height: height * 0.11,
                  decoration: const BoxDecoration(
                    color: kSwatchColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Center(
                          child: Text(
                            'ابحث من هنا',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontFamily: kFontFamily,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [

                  Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextFormField(

                      keyboardType: TextInputType.text,
                      controller: search,
             validator: (String? value) {
              if (value!.length == 0)
                   return 'Search must not be Empty';
                  return "";
                 },

                        onChanged: (s) async {
                          SearchCubit.get(context).getSearchData(text: s);
                        },

                        onFieldSubmitted: (s) {
                          SearchCubit.get(context).getSearchData(text: s);
                        },


                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: kFontFamily,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        filled: true,
                        fillColor: Colors.white,

                        prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.search,color: Colors.black54,)
                        ),
                        hintText: 'بحث',
                        hintStyle:  TextStyle(
                          color: kSwatchColor,

                          fontSize: 50.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is GetDataLoadingSearchState)
                    const LinearProgressIndicator(),
                  ConditionalBuilder(
                    // ignore: unnecessary_null_comparison
                    condition: SearchCubit.get(context).courses != null,
                    builder: (context) => Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,

                        itemCount: SearchCubit.get(context).courses.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: height * .33,
                          mainAxisSpacing: width * .03,
                          //   crossAxisSpacing: height * .02
                        ),
                        itemBuilder: (context, index) => Course(
                          width: width,
                          height: height,
                          courseImage:
                          SearchCubit.get(context).courses[index].image,
                          platformImage:
                          SearchCubit.get(context).courses[index].avatar,
                          rate:  SearchCubit.get(context).courses[index].rate,
                          courseName:
                          SearchCubit.get(context).courses[index].name,
                          coursePrice: '\$' +
                              SearchCubit.get(context)
                                  .courses[index]
                                  .price
                                  .toString(),

                          courseCommentsCount: '0',
                          courseStudentsCount: SearchCubit.get(context)
                              .courses[index]
                              .count_students
                              .toString(),
                          platformName: SearchCubit.get(context)
                              .courses[index]
                              .nameOwner,
                          onTap: () {
                            id=SearchCubit.get(context)
                                .courses[index].id.toString();
                            print(id);
                            //CourseDetails
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  CourseInfo(id:id )
                            ));
                          },
                          tag: '1',
                        ),
                      ),
                    ),
                    fallback: (context) => Container(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
