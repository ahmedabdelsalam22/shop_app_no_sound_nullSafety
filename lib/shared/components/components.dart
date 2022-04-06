import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';


 void navigateTo(context,Widget widget)
  {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>widget)
    );
  }

  void navigateToAndFinish(context,Widget widget)
  {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>widget),
         (route) => false);
  }


Widget defaultButton({
  double width =double.infinity,
  double height =55,
  Color background =Colors.blue,
  Function onPressed,
  String text,
})
{
  return Container(
    width: width,
    height: height,
    color: background,
    padding:const EdgeInsets.all(8.0),
    child: MaterialButton(
      onPressed:onPressed,
      child: Text(
        text,
        style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
    ),
  );
}



////////////////////////

Widget defaultFormField
    ({
  TextEditingController controller,
  TextInputType type,
  Function onSubmit,
  Function OnChange,
  Function validate,
  String labelText,
  IconData prefix,
  IconData suffix,
  Function onTap,
  bool isClickable=true,
  bool isPassword =false,
  Function suffixpressed

})

{
  return TextFormField(
    controller:controller,
    keyboardType: type,
    onFieldSubmitted:onSubmit,
    onChanged: OnChange,
    validator: validate,
    onTap: onTap,
    enabled: isClickable,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: labelText,
      border:const OutlineInputBorder(),
      prefixIcon: Icon(prefix),

      suffixIcon: suffix != null? IconButton(
        icon: Icon(suffix),onPressed: suffixpressed,
      ):null,
    ) ,

  );
}


Widget defaultTextButton({Function onPressed,String text})
{
  return TextButton(
      onPressed:onPressed ,
      child: Text(text)
  );
}



void showToast({@required String message,@required Color color}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}



Widget separatedDivider(){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      width: double.infinity,height: 1,
      color: Colors.grey[300],
    ),
  );
}


Widget buildListProduct(model,context, {bool isOldPrice =true})
{
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      width: 120,height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(
            children: [
              Image(
                image: NetworkImage(model.image),
                width:120,height: 120,
              ),
              if(model.discount !=0 && isOldPrice)
                Container(
                  color: Colors.red,
                  child:  const Text(
                    'Discount',
                    style: TextStyle(fontSize: 8,color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue
                      ),
                    ),
                    const SizedBox(width: 10),
                    if(model.discount !=0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                          //   print(model.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: ShopCubit.get(context).favorites[model.id] ? Colors.blue :Colors.grey,
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

