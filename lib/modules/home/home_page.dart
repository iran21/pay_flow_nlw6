import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/shared/theme/app_colors.dart';
import 'package:payflow/shared/theme/app_textstyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    Container(color: Colors.black),
    Container(color: Colors.blue),
  ];
  final controller = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: Container(
          height: 200,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Olá, ',
                      style: AppTextStyle.titleRegular,
                    ),
                    TextSpan(
                      text: 'Gabriela <3!',
                      style: AppTextStyle.titleBoldBackground,
                    )
                  ],
                ),
              ),
              subtitle: Text(
                'Mantenha suas contas em dia!',
                style: AppTextStyle.captionShape,
              ),
              trailing: Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.purarteadesivos.com.br%2Fproduto%2Fpikachu%2F&psig=AOvVaw2-YF0oINgl-QEYm3_FE2Rf&ust=1625435310033000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCKDWssPwx_ECFQAAAAAdAAAAABAD'),
                  radius: 24,
                ),
              ),
            ),
          ),
        ),
      ),
      body: pages[controller.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  controller.setPage(0);
                });
              },
              icon: Icon(
                Icons.home,
                color: AppColors.primary,
              ),
            ),
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primary),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/barcode_scanner');
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  controller.setPage(1);
                });
              },
              icon: Icon(
                Icons.description_outlined,
              ),
            )
          ],
        ),
      ),
    );
  }
}
