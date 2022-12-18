import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const route = "/edit_product_screen";
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();
  var gotData = true;
  var isLoading = false;
  var _editableProduct =
      Product(id: "", title: "", description: "", price: 0.0, imageUrl: "");
  var data = {
    "title": "",
    "price": "",
    "description": "",
    "imageUrl": "",
  };
  @override
  void initState() {
    super.initState();
    _imageFocusNode.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (gotData) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _editableProduct = Provider.of<Products>(context, listen: false)
            .getProductById(productId.toString());
        data = {
          "title": _editableProduct.title,
          "price": _editableProduct.price.toString(),
          "description": _editableProduct.description,
          "imageUrl": "",
        };
        _imageController.text = _editableProduct.imageUrl;
      }
    }
    gotData = false;
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageController.dispose();
    _imageFocusNode.dispose();
  }

  Future<void> errorDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Error Occured!"),
            content: const Text("Something went wrong."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }

  void updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveData() async {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();
    setState(() {
      isLoading = true;
    });
    if (_editableProduct.id.isNotEmpty) {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editableProduct.id, _editableProduct);
      } catch (e) {
        await errorDialog(context);
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editableProduct);
      } catch (e) {
        // ignore: prefer_void_to_null
        await errorDialog(context);
      }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Product"),
        actions: [
          IconButton(
            onPressed: _saveData,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: data["title"],
                        autofocus: true,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the title";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editableProduct = Product(
                            id: _editableProduct.id,
                            description: _editableProduct.description,
                            imageUrl: _editableProduct.imageUrl,
                            price: _editableProduct.price,
                            title: value!,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: data["price"],
                        decoration: const InputDecoration(
                          label: Text('Price'),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the price";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter the valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Value can't be negative and zero";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editableProduct = Product(
                            id: _editableProduct.id,
                            description: _editableProduct.description,
                            imageUrl: _editableProduct.imageUrl,
                            price: double.parse(value!),
                            title: _editableProduct.title,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: data["description"],
                        decoration: const InputDecoration(
                          label: Text('Description'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the description";
                          }
                          if (value.length < 10) {
                            return "Description length should be more than 10 characters";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        maxLines: 3,
                        onSaved: (value) {
                          _editableProduct = Product(
                            id: _editableProduct.id,
                            description: value!,
                            imageUrl: _editableProduct.imageUrl,
                            price: _editableProduct.price,
                            title: _editableProduct.title,
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(right: 10.0, top: 10.0),
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: _imageController.text.isEmpty
                                  ? const FittedBox(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          "No Image Added",
                                          softWrap: true,
                                        ),
                                      ),
                                    )
                                  : FittedBox(
                                      child: Image.network(
                                        _imageController.text,
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Image Url"),
                              ),
                              controller: _imageController,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              focusNode: _imageFocusNode,
                              validator: (value) {
                                var urlPattern =
                                    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?";
                                var result =
                                    RegExp(urlPattern, caseSensitive: false)
                                        .firstMatch(value!);
                                if (value.isEmpty) {
                                  return "Please enter the image url";
                                }
                                if (result == null) {
                                  return "Please enter correct url";
                                }

                                return null;
                              },
                              onEditingComplete: () {
                                setState(() {});
                              },
                              onFieldSubmitted: (_) {
                                _saveData();
                              },
                              onSaved: (value) {
                                _editableProduct = Product(
                                  id: _editableProduct.id,
                                  description: _editableProduct.description,
                                  imageUrl: value!,
                                  price: _editableProduct.price,
                                  title: _editableProduct.title,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
