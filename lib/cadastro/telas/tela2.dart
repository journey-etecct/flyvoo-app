import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

final List<String> carreiras = [
  "Qual área você deseja seguir?",
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
    carreiraEscolhida ??= carreiras.first;
    sexoEscolhido ??= sexos.first;
    pronomesEscolhidos ??= pronomes.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey2,
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
              if (value == carreiras.first) {
                return "*Obrigatório";
              }
              return null;
            },
            selectedItemBuilder: (context) => carreiras
                .map<Widget>(
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
          InkWell(
            onTap: () async {
              nascimento = await showDatePicker(
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
                  color: tema["noFundo"]!.withOpacity(.30),
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
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                )
              : const Row(),

          /* DropdownButtonFormField(
            icon: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
              child: Icon(Symbols.date_range),
            ),
            items: [
              DropdownMenuItem<DateTime>(
                value: nascimento,
                child: const Text("Data de Nascimento"),
              ),
            ],
            onChanged: (value) {},
            selectedItemBuilder: (context) => [
              const Text("Data de Nascimento"),
            ],
            onTap: () async {
              nascimento = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(
                  const Duration(days: 365 * 18),
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now().subtract(
                  const Duration(days: 365 * 18),
                ),
              );
              if (nascimento != null) {}
            },
          ), */
          const SizedBox(
            height: 15,
          ),
          DropdownButtonFormField(
            value: sexoEscolhido,
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
