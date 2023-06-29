import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/opcoes.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

final _txtNome = TextEditingController();

class Tela1 extends StatefulWidget {
  final Key formKey;
  const Tela1(this.formKey, {super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  IconData _iconeOlho = Icons.visibility_rounded;
  bool _txtEscondido = true;
  final _senhaConfKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _txtNome,
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

          /* TextFormField(
            controller: _txtTelefone,
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
              labelText: "Telefone Pessoal (Celular)",
              labelStyle: GoogleFonts.inter(fontSize: 20),
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
          ), */
          TextFormField(
            controller: txtSenha,
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 8) {
                return "Sua senha precisa ter mais de 8 caracteres.";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) => _senhaConfKey.currentState!.validate(),
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: GoogleFonts.inter(
                fontSize: 20,
              ),
              suffix: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Icon(
                      _iconeOlho,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        if (_txtEscondido) {
                          _iconeOlho = Icons.visibility_off_rounded;
                          _txtEscondido = false;
                        } else {
                          _iconeOlho = Icons.visibility_rounded;
                          _txtEscondido = true;
                        }
                      });
                    },
                  ),
                ),
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
            key: _senhaConfKey,
            controller: txtSenhaConf,
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (txtSenha.text != value) {
                return "Senhas não coincidem";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Confirmação da Senha",
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
        ],
      ),
    );
  }
}
