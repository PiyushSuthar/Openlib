import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openlib/ui/results_page.dart';
import 'package:openlib/ui/components/page_title_widget.dart';
import 'package:openlib/state/state.dart'
    show
        searchQueryProvider,
        selectedTypeState,
        selectedSortState,
        typeValues,
        sortValues;

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  void onSubmit(BuildContext context, WidgetRef ref) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ResultPage(
        searchQuery: ref.read(searchQueryProvider),
      );
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownTypeValue = ref.watch(selectedTypeState);
    final dropdownSortValue = ref.watch(selectedSortState);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText("Search"),
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
              child: TextField(
                showCursor: true,
                // cursorColor: Theme.of(context).colorScheme.secondary,

                decoration: InputDecoration(
                  label: const Text("Search"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    // color: Theme.of(context).colorScheme.secondary,
                    icon: const Icon(
                      Icons.search,
                      size: 23,
                    ),
                    onPressed: () => onSubmit(context, ref),
                  ),
                  filled: true,
                  // hintStyle: const TextStyle(
                  //     color: Colors.grey, fontWeight: FontWeight.bold),
                  hintText: "Harry Potter and th...",
                  // fillColor: Theme.of(context).colorScheme.primary,
                ),
                onSubmitted: (String value) => onSubmit(context, ref),
                style: const TextStyle(
                  // color: Theme.of(context).colorScheme.tertiary,
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                onChanged: (String value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 19),
                  child: SizedBox(
                    width: 200,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      value: dropdownTypeValue,
                      items: typeValues.keys
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        ref.read(selectedTypeState.notifier).state = val ?? '';
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 7, top: 19),
                  child: SizedBox(
                    width: 150,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Sort by',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                      value: dropdownSortValue,
                      items: sortValues.keys
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        ref.read(selectedSortState.notifier).state = val ?? '';
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    onSubmit(context, ref);
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Search",
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.search, size: 18),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
