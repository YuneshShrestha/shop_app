import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screen/edit_product_screen.dart';

class UserItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserItem(
      {Key? key, required this.id, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: SizedBox(
          width: 50,
          height: 50,
          child: FadeInImage(
              placeholder: const AssetImage('assets/images/loading_image.png'),
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover),
        ),
      ),
      trailing: Container(
        alignment: Alignment.centerRight,
        width: 100.0,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.route, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () async {
                  try {
                    // Ya listen false kina bhnae kina ki ya delete action
                    //lina matra ho product listener lae feri rebuild huna help garxa
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    scaffold.showSnackBar(const SnackBar(
                      content: Text(
                        "Deleting Failed",
                        textAlign: TextAlign.center,
                      ),
                      // duration: Duration(seconds: 3),
                    ));
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                )),
          ],
        ),
      ),
    );
  }
}
