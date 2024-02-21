import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

final List<String> sexos = [
  "Sexo",
  "Masculino",
  "Feminino",
  "Não Binário",
  "Prefiro não dizer",
];

final List<String> pronomes = [
  "Pronomes (opcional)",
  "ele/dele",
  "ela/dela",
  "elu/delu",
];

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  String _formatarDiaEMes(String insert) {
    final numero = int.parse(insert);
    if (numero < 10) {
      return "0$insert";
    } else {
      return insert;
    }
  }

  @override
  void initState() {
    super.initState();
    sexoEscolhido ??= sexos.first;
    pronomesEscolhidos ??= pronomes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey2,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              nascimento = await showDatePicker(
                errorInvalidText: "Formato inválido",
                helpText: "Selecione seu dia de nascimento",
                cancelText: "Cancelar",
                context: context,
                initialDate: nascimento ??
                    DateTime.now().subtract(
                      const Duration(days: 365 * 10),
                    ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now().subtract(
                  const Duration(days: 365 * 10),
                ),
              );
              setState(() {});
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Tema.noFundo.cor().withOpacity(.30),
                ),
              )),
              child: Row(
                children: [
                  Text(
                    nascimento == null
                        ? "Data de Nascimento"
                        : "Nascimento: ${_formatarDiaEMes(nascimento!.day.toString())}/${_formatarDiaEMes(nascimento!.month.toString())}/${nascimento?.year}",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                  const Expanded(child: Text("")),
                  const Icon(
                    Symbols.date_range,
                  ),
                ],
              ),
            ),
          ),
          nascimento == null
              ? Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*Obrigatório",
                        style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                )
              : const Row(),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            value: sexoEscolhido,
            dropdownColor: Tema.fundo.cor(),
            elevation: 1,
            style: GoogleFonts.inter(
              color: Tema.noFundo.cor(),
              fontSize: 20,
            ),
            borderRadius: BorderRadius.circular(20),
            icon: Image.asset(
              "assets/icons/seta.png",
              color: Tema.noFundo.cor(),
            ),
            selectedItemBuilder: (context) => sexos
                .map(
                  (e) => Text(
                    e,
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == sexos.first) {
                return "*Obrigatório";
              }
              return null;
            },
            items: sexos
                .map(
                  (String pele) => DropdownMenuItem<String>(
                    value: pele,
                    enabled: pele != sexos.first,
                    child: Text(pele),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  sexoEscolhido = value;
                });
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            value: pronomesEscolhidos,
            dropdownColor: Tema.fundo.cor(),
            elevation: 1,
            style: GoogleFonts.inter(
              color: Tema.noFundo.cor(),
              fontSize: 20,
            ),
            borderRadius: BorderRadius.circular(20),
            icon: Image.asset(
              "assets/icons/seta.png",
              color: Tema.noFundo.cor(),
            ),
            selectedItemBuilder: (context) => pronomes
                .map(
                  (e) => Text(
                    e,
                  ),
                )
                .toList(),
            items: pronomes
                .map(
                  (String pele) => DropdownMenuItem<String>(
                    value: pele,
                    enabled: pele != pronomes.first,
                    child: Text(pele),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  pronomesEscolhidos = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
