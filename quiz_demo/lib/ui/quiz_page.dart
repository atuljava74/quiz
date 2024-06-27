import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/view_model/quiz_view_model.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/widgets/app_button.dart';
import 'package:quiz_demo/widgets/custom_progress_bar.dart';
import 'package:quiz_demo/widgets/gradient_container.dart';
import 'package:quiz_demo/widgets/scaffold_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<QuizViewModel>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<QuizViewModel>();

    return ScaffoldWidget(
      title: "Today's Question",
      body: CustomProgressBar(
        visibility: _viewModel.loading,
        child: getPage(),
      ),
    );
  }

  Widget getPage() {
    if (_viewModel.question.id == -1) {
      return SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: Column(
        children: [
          Container(
            height: 200,
            margin: getMargin(top: 30),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GradientCardWithBubble(
                    child: Center(
                      child: Text(
                        _viewModel.question.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.Sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 70,
                      height: 70,
                      padding: getPadding(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.question_mark_outlined,
                          color: AppColors.primary,
                          size: 30.Sh,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: getMargin(vertical: 50),
              child: ListView.separated(
                itemCount: _viewModel.question.options.length,
                itemBuilder: (context, index) {
                  return optionWidget(_viewModel.question.options[index], index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20.Sh);
                },
              ),
            ),
          ),
          AppButton(title: "Next", onTap: () {
            _viewModel.submitQuestion();
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget optionWidget(String title, int index) {
    return GestureDetector(
      onTap: () {
        _viewModel.selectOption(index);
      },
      child: Container(
        width: double.infinity,
        padding: getPadding(vertical: 20),
        decoration: BoxDecoration(
          color:
              _viewModel.selectedOptionIndex == index ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: _viewModel.selectedOptionIndex == index
                ? Colors.transparent
                : Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17.Sp,
              fontWeight: FontWeight.w600,
              color: _viewModel.selectedOptionIndex == index
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.disposeValues();
    super.dispose();
  }
}
