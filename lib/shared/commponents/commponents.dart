
import 'package:flutter/material.dart';

import '../size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kScaffoldColor = Color(0xFFF8F8FF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]([0-9a-zA-Z]*[-._+])*[0-9a-zA-Z]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kFNameNullError = "Please Enter your name";
const String kPhoneNullError = "Please Enter your phone";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kAddressNullError = "Please Enter your address";
// SharedPreferences preferences ;
//
// Future<void> initPref() async
// {
//   return await SharedPreferences.getInstance().then((value)
//   {
//     preferences = value;
//     print('done =>');
//   }).catchError((error){
//     print('error => ${error.toString()}');
//
//   });
// }
//
// Future<bool> saveToken(String token) => preferences.setString('myToken', token);
//
// String getToken() => preferences.getString('myToken');
void navigateTo ({context , route })
{
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => route));
}
void navigateAndFinish({context, route}) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => route,
    ),
        (Route<dynamic> route) => false);

// Widget productCard({ product , function_fav , function_cart, bool inFavorites , bool inCart} )=> Padding(
//   padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//   child: Container(
//     width: getProportionateScreenWidth(140),
//     child: GestureDetector(
//      onTap: (){},
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//             height: getProportionateScreenHeight(140),
//             width: getProportionateScreenWidth(140),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Image.network(product.image ,)??'https://thumbs.dreamstime.com/t/k-loading-screen-black-line-white-background-animation-circle-ring-motion-graphic-141211116.jpg',
//           ),
//           const SizedBox(height: 10),
//           Container(
//             height: getProportionateScreenHeight(50.0),
//             child: Text(
//               product.name,
//               style: TextStyle(color: Colors.black),
//               maxLines: 2,
//             ),
//           ),
//           Container(
//             height: getProportionateScreenHeight(80.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${product.price}L.E",
//                       style: TextStyle(
//                         fontSize: getProportionateScreenWidth(16),
//                         fontWeight: FontWeight.w600,
//                         color: kPrimaryColor,
//                       ),
//                     ),
//                     if(product.price != product.oldPrice)
//                     Text(
//                       "${product.oldPrice}L.E",
//                       style: TextStyle(
//                         fontSize: getProportionateScreenWidth(14),
//                         fontWeight: FontWeight.w500,
//                         color: kTextColor,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     InkWell(
//                       borderRadius: BorderRadius.circular(50),
//                       onTap: function_fav,
//                       child: Container(
//                         padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//                         height: getProportionateScreenWidth(28),
//                         width: getProportionateScreenWidth(28),
//                         decoration: BoxDecoration(
//                           color: inFavorites
//                               ? kPrimaryColor.withOpacity(0.15)
//                               : kSecondaryColor.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: SvgPicture.asset(
//                           "assets/icons/Heart Icon_2.svg",
//                           color: inFavorites
//                               ? Color(0xFFFF4848)
//                               : Colors.grey[400],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: getProportionateScreenHeight(8.0),),
//                     InkWell(
//                       borderRadius: BorderRadius.circular(50),
//                       onTap: function_cart,
//                       child: Container(
//                         padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//                         height: getProportionateScreenWidth(28),
//                         width: getProportionateScreenWidth(28),
//                         decoration: BoxDecoration(
//                           color: inCart
//                               ? Colors.blue.withOpacity(0.15)
//                               : kSecondaryColor.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: SvgPicture.asset(
//                           "assets/icons/Cart Icon.svg",
//                           color: inCart
//                               ? Colors.blue
//                               : Colors.grey[500],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   ),
// );
// Widget sectionTitle({title})=> Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       title,
//       style: TextStyle(
//         fontSize: getProportionateScreenWidth(18),
//         color: Colors.black,
//       ),
//     ),
//     GestureDetector(
//       onTap: (){},
//       child: Text(
//         "See More",
//         style: TextStyle(color: Color(0xFFBBBBBB)),
//       ),
//     ),
//   ],
// );
// Widget specialOfferCard({category})=>Padding(
//   padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//   child: GestureDetector(
//     onTap: (){},
//     child: Container(
//       width: getProportionateScreenWidth(242),
//       height: getProportionateScreenWidth(100),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//       ),
//
//       child: Stack(
//         children: [
//           Image.network(
//             category.image??'https://thumbs.dreamstime.com/t/k-loading-screen-black-line-white-background-animation-circle-ring-motion-graphic-141211116.jpg',
//             fit: BoxFit.fill,
//             width:  getProportionateScreenWidth(242),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFF343434).withOpacity(0.4),
//                   Color(0xFF343434).withOpacity(0.15),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: getProportionateScreenWidth(15.0),
//               vertical: getProportionateScreenWidth(10),
//             ),
//             child:Text(
//                "${category.name}\n",
//               style: TextStyle(
//                 fontSize: getProportionateScreenWidth(18),
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// );
// Widget categoryCard ({icon , text}) => GestureDetector(
//   onTap: (){},
//   child: SizedBox(
//     width: getProportionateScreenWidth(55),
//     child: Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(getProportionateScreenWidth(15)),
//           height: getProportionateScreenWidth(55),
//           width: getProportionateScreenWidth(55),
//           decoration: BoxDecoration(
//             color: Color(0xFFFFECDF),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: SvgPicture.asset(icon),
//         ),
//         SizedBox(height: 5),
//         Text(text, textAlign: TextAlign.center)
//       ],
//     ),
//   ),
// );
// Widget appBarIconButton({numOfItem , icon})=>  InkWell(
//   borderRadius: BorderRadius.circular(100),
//   onTap: (){},
//   child: Stack(
//     overflow: Overflow.visible,
//     children: [
//       Container(
//         padding:
//         EdgeInsets.all(getProportionateScreenWidth(12)),
//         height: getProportionateScreenWidth(46),
//         width: getProportionateScreenWidth(46),
//         decoration: BoxDecoration(
//           color: kSecondaryColor.withOpacity(0.1),
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(icon),
//       ),
//       if (numOfItem != 0)
//         Positioned(
//           top: -3,
//           right: 0,
//           child: Container(
//             height: getProportionateScreenWidth(16),
//             width: getProportionateScreenWidth(16),
//             decoration: BoxDecoration(
//               color: Color(0xFFFF4848),
//               shape: BoxShape.circle,
//               border:
//               Border.all(width: 1.5, color: Colors.white),
//             ),
//             child: Center(
//               child: Text(
//                 "$numOfItem",
//                 style: TextStyle(
//                   fontSize: getProportionateScreenWidth(10),
//                   height: 1,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         )
//     ],
//   ),
// );
Widget splashContentItem ({@required textContent  ,@required image , flex = 2}) => Column(
  children: [

    SizedBox(height: getProportionateScreenHeight(20.0),),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Booking App' , style: TextStyle(
              color: Colors.blue,
              fontSize: getProportionateScreenWidth(32),
            ),),
            SizedBox(height: getProportionateScreenHeight(10.0),),
            Text(textContent , style: TextStyle(
              fontSize: getProportionateScreenWidth(20.0),
              fontWeight: FontWeight.w400,
            ),textAlign: TextAlign.center,),
          ],
        ),
      ),
    ),
    Expanded(
        flex: flex,
        child: Image.asset(image,)),
    SizedBox(height: 10.0,),
  ],
);
Widget buildDot({@required index , currentPage}) =>  AnimatedContainer(
  height: 6.0,
  width: currentPage == index ? 30.0 : 6.0,
  margin: EdgeInsetsDirectional.only(end: 5.0),
  decoration: BoxDecoration(
    color: currentPage == index ? Colors.blue : Colors.grey[300],
    borderRadius: BorderRadius.circular(3.0),
  ), duration: Duration(milliseconds: 250),
);
// Widget defaultButton ({padding  , radius , text , function}) =>   Padding(
//   padding:  EdgeInsets.symmetric(horizontal: padding),
//   child: Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: kPrimaryColor,
//
//       borderRadius: BorderRadius.circular(radius),
//     ),
//     child: FlatButton(onPressed: function, child: Text(text , style: TextStyle(
//       color: Colors.white,
//     ),),),
//   ),
// );
// Widget defaultFormField({type , controller ,labelText  , radius ,validator , onChanged , hintText , isPassword = false}) =>  TextFormField(
//   keyboardType: type,
//   onChanged: onChanged,
//   validator: validator,
//   decoration: InputDecoration(
//     contentPadding: EdgeInsets.all(18.0),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius,),),
//     labelText: labelText,
//     hintText: hintText ,
//
//
//
//   ),
//   obscureText: isPassword,
//   controller: controller,
// );
// Widget socialItem({icon , function}) =>   GestureDetector(
//   onTap: function,
//   child: Container(
//     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//     child:
//     SvgPicture.asset(icon ,),
//     height: getProportionateScreenHeight(40),
//     width: getProportionateScreenWidth(40),
//     decoration: BoxDecoration(
//       shape: BoxShape.circle ,
//       color: Colors.grey[200],
//     ),
//   ),
// );
// Widget formErrorText ({@required error}) =>  Padding(
//   padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
//   child:   Row(
//     children: [
//       SvgPicture.asset('assets/icons/Error.svg' , height: getProportionateScreenHeight(14), width: getProportionateScreenWidth(14),),
//       SizedBox(width: getProportionateScreenWidth(10)),
//       Text(error),
//     ],
//   ),
// );
// Widget categoryCardItem(item) =>  Padding(
//   padding:  EdgeInsets.only(right: getProportionateScreenWidth(16.0)),
//   child:   Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundColor: kPrimaryColor,
//           radius: 25.0,
//           child: SvgPicture.asset(item['icon'] , height: getProportionateScreenHeight(24.0),),
//         ),
//         SizedBox(height: getProportionateScreenHeight(15.0),),
//         Text(item['text'] , style: TextStyle(fontSize: getProportionateScreenWidth(16.0)),),
//       ],
//     ),
//     height: getProportionateScreenHeight(180.0),
//     width: getProportionateScreenWidth(155.0),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(24.0),
//     ),
//
//   ),
// );
// Widget courseCardItem(item) =>  Padding(
//   padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(16.0)),
//   child:   Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(getProportionateScreenWidth(24.0)),
//     ),
//     child: Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: getProportionateScreenWidth(20.0),
//           vertical: getProportionateScreenHeight(18.0)),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: getProportionateScreenWidth(25.0),
//             backgroundColor: kPrimaryColor,
//             child: Icon(
//               Icons.school,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(width: getProportionateScreenWidth(6.0)),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 item['title'],
//                 style: TextStyle(
//                     fontSize:
//                     getProportionateScreenWidth(16.0)),
//               ),
//               Container(
//                   width: getProportionateScreenWidth(156.0),
//                   child: Text(
//                     item['slug'],
//                     style: TextStyle(
//                         fontSize:
//                         getProportionateScreenWidth(8.0)),
//                   )),
//             ],
//           ),
//           Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Total ratings' , style: TextStyle(fontSize: getProportionateScreenWidth(8.0)),),
//               SizedBox(
//                 height: getProportionateScreenHeight(7.0),
//               ),
//               RatingBar.builder(
//                 itemSize: getProportionateScreenWidth(8.0),
//                 initialRating: 3,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemPadding:
//                 EdgeInsets.symmetric(horizontal: 4.0),
//                 itemBuilder: (context, _) => Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print(rating);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// );
// void showToast({@required text, isError = false}) => Fluttertoast.showToast(
//     msg: text.toString(),
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: isError ? Colors.red : Colors.grey[400],
//     textColor: Colors.black,
//     fontSize: 16.0);
// Widget profileCategoryItem({text , }) =>  Padding(
//   padding:
//   EdgeInsets.only(right: getProportionateScreenWidth(24.0)),
//   child: Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircleAvatar(
//           backgroundColor: kPrimaryColor,
//           radius: 25.0,
//           child: Text('4' , style: TextStyle(color: Colors.white , fontSize: getProportionateScreenWidth(24.0)),),
//         ),
//         SizedBox(
//           height: getProportionateScreenHeight(15.0),
//         ),
//         Text(
//           'My',
//           style: TextStyle(
//               fontSize: getProportionateScreenWidth(16.0)),
//         ),
//         Text(
//           text,
//           style: TextStyle(
//               fontSize: getProportionateScreenWidth(16.0)),
//         ),
//       ],
//     ),
//     height: getProportionateScreenHeight(180.0),
//     width: getProportionateScreenWidth(155.0),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(24.0),
//     ),
//   ),
// );