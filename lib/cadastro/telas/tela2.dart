import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

final _txtTelefoneE = TextEditingController();

class Tela2 extends StatefulWidget {
  final Key formKey;
  const Tela2(this.formKey, {super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final List<String> carreiras = [
    "Qual carreira você deseja seguir?",
    "carreira1",
    "carreira2",
    "carreira3",
    "carreira4",
    "carreira5",
    "carreira6",
    "carreira7",
    "carreira8",
    "carreira9",
  ];
  late String carreiraEscolhida;

  final List<String> etnias = [
    "Cor de Pele",
    "Amarelo",
    "Branco",
    "Pardo",
    "Indígena",
    "Preto"
  ];
  late String peleEscolhida;

  @override
  void initState() {
    carreiraEscolhida = carreiras.first;
    peleEscolhida = etnias.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: carreiraEscolhida,
            dropdownColor: tema["fundo"],
            style: GoogleFonts.inter(
              color: tema["noFundo"],
              fontSize: 17,
            ),
            elevation: 1,
            validator: (value) {
              if (value != null && value == carreiras.first) {
                return "*Obrigatório";
              }
              return null;
            },
            selectedItemBuilder: (context) => carreiras
                .map(
                  (e) => Text(
                    e,
                  ),
                )
                .toList(),
            borderRadius: BorderRadius.circular(20),
            icon: Image.asset(
              "assets/icons/seta.png",
              color: tema["noFundo"],
            ),
            items: carreiras
                .map(
                  (String carreira) => DropdownMenuItem<String>(
                    value: carreira,
                    enabled: carreira != carreiras.first,
                    child: Text(carreira),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  carreiraEscolhida = value;
                });
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            value: peleEscolhida,
            dropdownColor: tema["fundo"],
            elevation: 1,
            style: GoogleFonts.inter(
              color: tema["noFundo"],
              fontSize: 20,
            ),
            borderRadius: BorderRadius.circular(20),
            icon: Image.asset(
              "assets/icons/seta.png",
              color: tema["noFundo"],
            ),
            selectedItemBuilder: (context) => etnias
                .map(
                  (e) => Text(
                    e,
                  ),
                )
                .toList(),
            items: etnias
                .map(
                  (String pele) => DropdownMenuItem<String>(
                    value: pele,
                    enabled: pele != etnias.first,
                    child: Text(pele),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  peleEscolhida = value;
                });
              }
            },
          ),
          TextFormField(
            controller: _txtTelefoneE,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return null;
              } else if (value.length < 14) {
                return "Muito curto";
              }
              return null;
            },
            autofillHints: const [AutofillHints.telephoneNumberNational],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Telefone Profissional (Opcional)",
              labelStyle: GoogleFonts.inter(fontSize: 18),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"]!,
                ),
              ),
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
