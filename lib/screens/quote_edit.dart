//
// import 'package:blog/models/post.dart';
// import 'package:blog/providers/post.dart';
// import 'package:blog/widget/canvas.dart';
// import 'package:blog/widget/quote_form/post_controller.dart';
// import 'package:blog/widget/quote_form/quote_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class QuoteEditScreen extends StatefulWidget {
//   const QuoteEditScreen({super.key});
//
//   @override
//   State<QuoteEditScreen> createState() => _QuoteEditScreenState();
// }
//
// class _QuoteEditScreenState extends State<QuoteEditScreen> {
//   late String quoteId;
//   Post? updatedQuote;
//   final quoteFormController = QuoteFormController();
//   late PostsProvider quotesProvider;
//
//   void editQuote() {
//     if (quoteFormController.formKey.currentState!.validate()) {
//       final quoteData = quoteFormController.getUpdatedQuoteData();
//       quotesProvider.edit(quoteId, quoteData);
//       if (quotesProvider.isFetchErrors) {
//         WidgetsBinding.instance.addPostFrameCallback((duration) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Something went wrong while updating'),
//               action: SnackBarAction(
//                 label: 'Try again',
//                 onPressed: () => quotesProvider.edit(quoteId, quoteData),
//               ),
//             ),
//           );
//         });
//       } else {
//         Navigator.of(
//           context,
//         ).pop();
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     Future.microtask(() {
//       quotesProvider.clearErrors();
//     });
//     super.dispose();
//     quoteFormController.dispose();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     quotesProvider = context.watch<PostsProvider>();
//     quoteId = ModalRoute.of(context)!.settings.arguments as String;
//     updatedQuote = quotesProvider.posts.firstWhere(
//       (quote) => quote.id == quoteId,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (updatedQuote != null) {
//       quoteFormController.textController.text = updatedQuote!.text;
//       quoteFormController.authorController.text = updatedQuote!.author;
//       quoteFormController.categoryIdController.text = updatedQuote!.title;
//       quoteFormController.createdOnController.text =
//           updatedQuote!.createdOn.toIso8601String();
//     }
//     return ScreenCanvas(
//       widgets: [
//         QuoteForm(controller: quoteFormController),
//         TextButton(onPressed: editQuote, child: Text("Edit quote")),
//       ],
//       appBarTitleText: "Edit quote",
//     );
//   }
// }
