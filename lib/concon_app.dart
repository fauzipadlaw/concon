import 'package:concon/components/footer.dart';
import 'package:concon/components/scan_text.dart';
import 'package:concon/models/search.dart';
import 'package:concon/models/suggestion.dart';
import 'package:concon/requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:searchfield/searchfield.dart';

class ConconApp extends StatefulWidget {
  const ConconApp({super.key});

  @override
  State<ConconApp> createState() => _ConconAppState();
}

class _ConconAppState extends State<ConconApp> {
  List<SearchFieldListItem<SuggestionData>> suggestions = [];
  TextEditingController textController = TextEditingController();
  final focus = FocusNode();

  getSuggestionData(String query) async {
    SuggestionDataModel? suggestionModel = await getSuggestions(query);

    List<SuggestionData> sgs = suggestionModel?.data ?? [];
    setState(() {
      suggestions = sgs
          .map((e) => SearchFieldListItem<SuggestionData>(e.title ?? ''))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (!(MediaQuery.of(context).viewInsets.bottom > 0))
                    const Text(
                      "Selamat datang di ConCon",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  if (!(MediaQuery.of(context).viewInsets.bottom > 0))
                    const Text(
                      "ConCon adalah aplikasi untuk mengecek suatu merek adalah pendukung pendudukan ilegal Israel terhadap Palestina atau tidak.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    )
                ],
              ),
            ),
            if (!(MediaQuery.of(context).viewInsets.bottom > 0)) const Spacer(),
            if (MediaQuery.of(context).viewInsets.bottom > 0)
              const SizedBox(
                height: 24,
              ),
            Center(
              child: SearchField<SuggestionData>(
                controller: textController,
                onSearchTextChanged: (query) {
                  getSuggestionData(query);
                  return null;
                },
                suggestionDirection: SuggestionDirection.down,
                key: const Key('searchfield'),
                hint: 'Cari merek',
                searchStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.8),
                ),
                searchInputDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const ScanText(),
                          ),
                        );

                        if (result is String) {
                          if (result.trim() != '') {
                            textController.text = result;
                            await checkBrandStatus();
                          }
                        }
                      },
                      child: const Icon(Icons.camera_alt),
                    )),
                maxSuggestionsInViewPort: 6,
                itemHeight: 40,
                suggestionStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.8),
                ),
                suggestionsDecoration: SuggestionDecoration(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    border: Border.all(color: Colors.grey.withOpacity(0.8)),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                suggestions: suggestions,
                suggestionItemDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: Colors.transparent,
                        style: BorderStyle.solid,
                        width: 1.0)),
                onSuggestionTap: (SearchFieldListItem<SuggestionData> x) async {
                  await checkBrandStatus();
                },
                suggestionAction: SuggestionAction.next,
                textInputAction: TextInputAction.done,
                focusNode: focus,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
      persistentFooterButtons: [Footer()],
    );
  }

  Future<void> checkBrandStatus() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Memuat',
      text: 'Memeriksa Data',
      disableBackBtn: true,
    );
    SearchModel? searchMd = await getBrandStatus(textController.text, "Keyword")
        .whenComplete(() => Navigator.of(context).pop());
    if (searchMd != null) {
      Search? search = searchMd.data;

      if (search != null) {
        if (!mounted) return;
        if (search.id == "0") {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: search.title,
            text: 'Data tentang merek ini TIDAK DITEMUKAN.',
          );
        } else {
          if (search.isProIsrael == "1") {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              title: search.title,
              text:
                  'Merek ini MENDUKUNG pendudukan ilegal Israel terhadap Palestina.',
            );
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: search.title,
              text:
                  'Merek ini TIDAK mendukung pendudukan ilegal Israel terhadap Palestina.',
            );
          }
        }
      }
    }
    setState(() {
      textController.value = TextEditingValue.empty;
      suggestions = [];
    });
  }
}
