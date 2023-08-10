import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMicrosoft1 extends StatefulWidget {
  const TelaMicrosoft1({super.key});

  @override
  State<TelaMicrosoft1> createState() => _TelaMicrosoft1State();
}

class _TelaMicrosoft1State extends State<TelaMicrosoft1> {
  @override
  void initState() {
    super.initState();
    txtNome.text = userFlyvoo!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey1,
      child: Column(
        children: [
          TextFormField(
            controller: txtNome,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            maxLength: 255,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.contains(
                RegExp(
                  r'''[!@#<>?":,.'_/`~;[\]\\|=+)(*&^%0-9-]''',
                ),
              )) {
                return "Nome inválido";
              } else if (!value.contains(
                RegExp(
                  r'^[A-ZÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð][a-zàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšž∂ð]{1,}( {1,2}[A-ZÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð][a-za-zàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšž∂ð]{1,}){1,10}$',
                ),
              )) {
                return "Insira seu nome completo";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.name],
            decoration: InputDecoration(
              labelText: "Nome Completo",
              labelStyle: GoogleFonts.inter(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"]!,
                ),
              ),
            ),
            cursorColor: tema["primaria"],
          ),
          TextFormField(
            controller: txtTelefone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 14) {
                return "Muito curto";
              }
              return null;
            },
            autofillHints: const [AutofillHints.telephoneNumberNational],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Telefone Profissional",
              labelStyle: GoogleFonts.inter(fontSize: 20),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"]!,
                ),
              ),
              prefixText: "+55 ",
            ),
            cursorColor: tema["primaria"],
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: "BR",
              )
            ],
          ),
        ],
      ),
    );
  }
}
