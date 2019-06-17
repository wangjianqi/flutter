// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_gallery/demo/shrine/model/app_state_model.dart';
import 'package:flutter_gallery/demo/shrine/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({ this.imageAspectRatio = 33 / 49, this.product })
      : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Product product;

  static const double kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    ///MARK ---:NumberFormat
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      ///小数位
      decimalDigits: 0,
      locale: Localizations.localeOf(context).toString(),
    );

    final ThemeData theme = Theme.of(context);

    final Image imageWidget = Image.asset(
      product.assetName,
      package: product.assetPackage,
      fit: BoxFit.cover,
    );

    return ScopedModelDescendant<AppStateModel>(
      builder: (BuildContext context, Widget child, AppStateModel model) {
        return GestureDetector(
          onTap: () {
            model.addProductToCart(product.id);
          },
          child: child,
        );
      },
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///MARK ---:AspectRatio
              AspectRatio(
                aspectRatio: imageAspectRatio,
                child: imageWidget,
              ),
              SizedBox(
                height: kTextBoxHeight * MediaQuery.of(context).textScaleFactor,
                width: 121.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      ///MARK ---:format
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
    );
  }
}
