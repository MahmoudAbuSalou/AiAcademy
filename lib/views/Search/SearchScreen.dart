import 'package:academy/views/Search/cubit/search_cubit.dart';
import 'package:academy/views/Search/cubit/search_state.dart';
import 'package:academy/views/course_info.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../components/components.dart';
import '../../shared/components/components.dart';


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
      create: (context) => SearchCubit()..getSearchData(text: search.text),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: search,
                    validator: (String? value) {
                      if (value!.length == 0)
                        return 'Search must not be Empty';
                      return "";
                    },
                    onChanged: (s) async {
                      SearchCubit.get(context).getSearchData(text: s);
                    },
                    enableSuggestions: true,
                    onFieldSubmitted: (s) {
                      SearchCubit.get(context).getSearchData(text: s);
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      label: Text('ابحث:'),
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
                          mainAxisExtent: height * .37,
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
                                // const CoursePage(
                                //       courseImage:
                                //           'https://aiacademy.info/wp-content/uploads/2020/04/imageedit_1_7774889739-768x512.webp',
                                //       degree: 'Diploma',
                                //       platformImage:
                                //           'https://lh3.googleusercontent.com/a-/AOh14Giz3B5xi3irpfXiJEiaB5tmmLcLVWMcB9xM7t4o=s96-c',
                                //       platformName: 'MAad',
                                //       tag: '1',
                                //     )
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
