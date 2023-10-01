import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaGoogle1 extends StatefulWidget {
  const TelaGoogle1({super.key});

  @override
  State<TelaGoogle1> createState() => _TelaGoogle1State();
}

class _TelaGoogle1State extends State<TelaGoogle1> {
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
                  color: Tema.primaria.cor(),
                ),
              ),
            ),
            cursorColor: Tema.primaria.cor(),
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
                  color: Tema.primaria.cor(),
                ),
              ),
              prefixText: "+55 ",
            ),
            cursorColor: Tema.primaria.cor(),
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
