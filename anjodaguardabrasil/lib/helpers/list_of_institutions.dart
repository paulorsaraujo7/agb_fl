import 'package:anjodaguardabrasil/models/institution.dart';

class Institutions {
  static List<Institution> listOfInstitutions = [
    //EMERGÊNCIAS
    Institution(
        short: "PM",
        name: "Polícia Militar",
        phone: "190",
        explanation: "Chame a Polícia Militar para preservar a segurança e a "
            "tranquilidade públicas; para o policiamento de fiscalização em seu "
            "bairro, quando houver situações de ilegalidade, de insegurança etc; "
            "no caso de falha operacional dos outros órgãos de segurança pública, "
            "como por exemplo, a segurança interna em estabelecimentos presidiários; "
            "para executar o serviço da Polícia Civil em caso de greve da mesma, "
            "ou até mesmo lavrar o flagrante delito.",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "SAMU",
        name: "Serviço de Atendimento Móvel de Urgência",
        phone: "192",
        explanation:
            "Chame o SAMU quando precisar de socorro em casos de emergência. "
            "Uma equipe de profissionais da saúde, como médicos, enfermeiros, socorristas, "
            "estará pronta a atender a urgências de natureza traumática, clínica, "
            "pediátrica, cirúrgica, gineco-obstetrícia e de saúde mental da população.",
        url:
            "https://antigo.saude.gov.br/saude-de-a-z/servico-de-atendimento-movel-de-urgencia-samu-192",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "CBM",
        name: "Corpo de Bombeiros Militar",
        phone: "193",
        explanation: "Chame o Corpo de Bombeiros em casos de incêndios, "
            "afogamentos (mar, rios, lagos, etc), "
            "salvamentos aéreos (montanhas, edifícios etc), "
            "desmoronamentos, atendimento pré-hospitalar, e "
            "defesa civil (em caso de desastre ou calamidade pública).",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "PC",
        name: "Polícia Civil",
        phone: "197",
        explanation:
            "Chame a Polícia Civil quando for necessária a investigação "
            "criminal, envolvendo infrações penais como roubo, furto, homicídio etc.",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "PRE",
        name: "Polícia Rodoviária Estadual",
        phone: "198",
        explanation: "Chame a PRE para acidentes e ocorrências diversas em "
            "estradas estaduais.",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "PRF",
        name: "Polícia Rodoviária Federal",
        phone: "191",
        explanation: "Chame a PRF quando houver acidentes, irregularidades, "
            "denúncias de roubo/furto de veículos e crimes ocorridos em "
            "rodovias federais, como a BR-101, por exemplo.",
        url: "https://www.gov.br/prf/pt-br",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "PF",
        name: "Polícia Federal",
        phone: "194",
        explanation:
            "Chame a Polícia Federal para prevenir e reprimir o tráfico "
            "ilegal de entorpecentes e drogas, contrabando etc; "
            "para infrações penais praticadas contra os bens, serviços e interesses da União; "
            "quando precisar da polícia marítima, aeroportuária, de fronteiras, "
            "ou judiciária; quando precisar de serviços como retirar passaporte, "
            "certidão de antecedentes criminais, "
            "registro ou porte de arma de fogo, carteira de identidade estrangeiro (CIE), "
            "carteira nacional de vigilante (CNV).",
        url: "https://www.gov.br/pf/pt-br",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "DD",
        name: "Disque Denúncia",
        phone: "181",
        explanation:
            "Ligue para o 181 para denunciar crimes e criminosos de qualquer natureza. "
            "O Disque Denúncia da Polícia Militar não identifica os denunciantes "
            "e as ligações podem ser anônimas. "
            "Você pode ligar também para fazer denúncias sobre o uso indevido de dinheiro, bens ou serviços que "
            "sejam públicos ou qualquer tipo de vantagem patrimonial indevida em "
            "razão do exercício de cargo, mandato, função, emprego ou ato "
            "cometido contra a Administração Pública",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "CVV",
        name: "Centro de Valorização da Vida",
        phone: "188",
        explanation:
            "O CVV – Centro de Valorização da Vida realiza apoio emocional "
            "e prevenção do suicídio, atendendo voluntária e gratuitamente todas"
            " as pessoas que querem e precisam conversar, sob total sigilo "
            "por telefone, email e chat 24 horas todos os dias.",
        url: "https://www.cvv.org.br/",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "EE",
        name: "Energia Elétrica no seu Estado",
        phone: "116",
        explanation: "Ligue para o 116 para informar problemas com a energia "
            "elétrica de sua residência, indústria, etc.",
        url: "",
        institutionType: InstitutionType.emergence),
    Institution(
        short: "A & E",
        name: "Água e Esgoto",
        phone: "115",
        explanation: "Ligue para o serviço de Água e Esgoto para problemas no "
            "fornecimento de água em sua residência; "
            "no serviço de saneamento etc.",
        url: "",
        institutionType: InstitutionType.emergence),

    //------------OUTROS SERVIÇOS

    /*
    Institution(
        short: "MPF",
        name: "Ministério Público Federal",
        phone: "",
        explanation:
            "Compete ao MPF a proteção dos direitos previstos na Constituição Federal; "
            "a proteção do patrimônio público e social, do meio ambiente, dos bens e "
            "direitos de valor artístico, estético, histórico, turístico e paisagístico; "
            "a proteção dos interesses individuais indisponíveis, difusos e coletivos, "
            "relativos às comunidades indígenas, à família, à criança, ao adolescente, "
            "ao idoso, às minorias étnicas e ao consumidor; "
            "outros interesses individuais indisponíveis, homogêneos, sociais, difusos e coletivos;"
            "\n\nPara fazer uma denúncia, procure a Procuradoria da República no seu estado. "
                "A lista das procuradoriras pode ser encontrada no site principal indicado abaixo.",
        url: "http://www.mpf.mp.br/",
        institutionType: InstitutionType.other_services),

    Institution(
        short: "MPT",
        name: "Ministério Público do Trabalho",
        phone: "",
        explanation:
            "Compete ao MPT fiscalizar"
                " o cumprimento da legislação trabalhista quando houver interesse público, "
                "procurando regularizar e mediar as relações entre empregados e empregadores.\n\n "
                "Cabe ainda ao MPT promover a ação civil pública no âmbito da Justiça do Trabalho"
                " para defesa de interesses coletivos, quando desrespeitados direitos sociais"
                " constitucionalmente garantidos aos trabalhadores. "
                "Também pode manifestar-se em qualquer fase do processo trabalhista, "
                "quando entender existente interesse público que justifique.\n\n "
                "O MPT pode ser árbitro ou mediador em dissídios coletivos e "
                "pode fiscalizar o direito de greve nas atividades essenciais. "
                "\n\nPara fazer uma denúncia, procure a Procuradoria do Trabalho no seu estado. "
                "A lista das procuradorias pode ser encontrada no site principal indicado abaixo.\n ",
        url: "http://www.mpt.mp.br/",
        institutionType: InstitutionType.other_services),
     */

    Institution(
        short: "DETRAN",
        name: "Departamento Estadual de Trânsito",
        phone: "154",
        explanation:
            "Ligue para o DETRAN e obtenha informações sobre os serviços "
            "oferecidos pelo Departamento de Trânsito de seu Estado.",
        url: "",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "ADAQ",
        name: "Assistência a Dependentes de Agentes Químicos",
        phone: "132",
        explanation: "Ligue para o 132 e saiba como dar assistência a "
            "dependentes de drogas, álcool e entorpecentes.",
        url: "",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "CAPDF",
        name: "Centro de Atendimento à Pessoa com Deficiência Física",
        phone: "142",
        explanation: "Ligue para o 142 e saiba como dar assistência a pessoas "
            "com deficiência física.",
        url: "",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "ANATEL",
        name: "Agência Nacional de Telecomunicações",
        phone: "1331",
        explanation: "Ligue para a Agência Nacional de Telecomunicações para "
            "problemas nos serviços de telefonia fixa e móvel. "
            "Registre reclamações e denúncias contra operadoras; "
            "e obtenha informações sobre a Anatel. "
            "A ligação pode ser feita "
            "de qualquer localidade no País."
            "Pessoas com deficiência auditiva ou da fala devem "
            "ligar 1332 de qualquer telefone adaptado.",
        url: "https://www.gov.br/anatel/pt-br/",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "ANVISA",
        name: "Agência Nacional de Vigilância Sanitária",
        phone: "08006429782",
        explanation: "Ligue para a central de atendimento da Agência Nacional "
            "de Vigilância Sanitária para esclarecer dúvidas e solicitar "
            "informações. "
            "Fale de qualquer estado do Brasil. "
            "A ligação é gratuita. ",
        url: "https://www.gov.br/anvisa/pt-br",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "IBAMA",
        name: "Instituto Brasileiro do Meio Ambiente e dos Recursos Naturais",
        phone: "08000618080",
        explanation: "Ligue para o IBAMA para se manifestar sobre suas ações "
            "através da Linha Verde: uma Central de Atendimento ao público, "
            "disponibilizada para todo o Brasil. A ligação é gratuita.",
        url: "https://www.gov.br/ibama/pt-br",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "SUS",
        name: "Sistema Único de Saúde",
        phone: "136",
        explanation:
            "Ligue para a Ouvidoria do Sistema Único de Saúde e faça consultas sobre diversos temas relacionados à saúde, bem como a ações e programas do Ministério da Saúde. "
            "O disque saúde funciona 24 horas."
            "A ligação pode ser originada de telefones fixos, públicos ou celulares, de qualquer local do país.",
        url: "https://conectesus-paciente.saude.gov.br/menu/home",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "DZ",
        name: "Disque Zoonose",
        phone: "08002815678",
        explanation:
            "Ligue para o Disque Zoonose para fazer denúncias de maus tratos contra animais; "
            "pedir informações e orientações sobre zoonoses (doenças transmitidas por animais) "
            "que põem em risco a saúde pública; para a vacinação em cães e gatos; "
            "e em caso de animais atropelados.",
        url:
            "https://www.gov.br/pt-br/assuntos/agenda/agenda/d/disque-zoonose/disque-zoonose-",
        institutionType: InstitutionType.other_services),
    Institution(
        short: "BC",
        name: "Banco Central",
        phone: "145",
        explanation:
            "Ligue para o Banco Central para fazer uma reclamação contra "
            "instituição bancária fiscalizada pelo Banco Central ou para "
            "encaminhar reclamações, sugestões, críticas ou elogios relacionados "
            "aos serviços prestados pelo Banco Central."
            "A ligação é o custo de ligação local, de qualquer parte do País. ",
        url: "https://www.bcb.gov.br/",
        institutionType: InstitutionType.other_services),

    //----APPS-----------------------------------------------------------------
    Institution(
        short: "",
        name: "gov.br",
        phone: "",
        explanation:
            "Nesse App é possível acessar qualquer serviço do governo que tenha "
            "o botão “Entrar com gov.br”, como CPF e CNH Digital. ",
        url: "https://play.google.com/store/apps/details?id=br.gov.meugovbr",
        icon: "assets/images/imgIconAppGovBr.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "CPF Digital",
        phone: "",
        explanation:
            "O App oferece ao cidadão serviços vinculados ao seu CPF junto à Receita "
            "Federal do Brasil, Ministério da Economia e Governo Federal.",
        url: "https://play.google.com/store/apps/details?id=br.gov.cpf_digital",
        icon: "assets/images/imgIconAppCPFDigital.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Carteira Digital de Trânsito",
        phone: "",
        explanation:
            "A Carteira Digital de Trânsito (CDT) é a CNH Digital mais outras "
            "funcionalidades. No App estão a Carteira Nacional de Habilitação - CNH, "
            "bem como a versão digital do Certificado de "
            "Registro e Licenciamento de Veículo – CRLV.",
        url: "https://play.google.com/store/apps/details?id=br.gov.serpro.cnhe",
        icon: "assets/images/imgIconAppCNH.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Consumidor.gov.br",
        phone: "",
        explanation:
            "O App é um serviço público para solução de conflitos de consumo. "
            "É um serviço de ação integrada entre o Ministério da Justiça, "
            "os Órgãos do Sistema Nacional de Defesa do Consumidor "
            "e empresas participantes.",
        url: "https://play.google.com/store/apps/details?id=br.com.consumidor",
        icon: "assets/images/imgIconAppConsumidorGovBr.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "SINE Fácil",
        phone: "",
        explanation:
            "O App permite que o cidadão brasileiro possa pesquisar e concorrer a vagas de emprego disponibilizadas no sistema SINE – Sistema Nacional de Empregos.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.dataprev.sinefacil",
        icon: "assets/images/imgIconAppSineFacil.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Carteira de Trabalho Digital",
        phone: "",
        explanation:
            "O App possibilita ao trabalhador acesso aos seus dados pessoais, "
            "bem como aos seus contratos de trabalho registrados na "
            "Carteira de Trabalho e Previdência Social.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.dataprev.carteiradigital",
        icon: "assets/images/imgIconAppCarteiraDigitalTrabalho.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "SouGov.br",
        phone: "",
        explanation:
            "Aplicativo para os servidores ativos, aposentados e pensionistas do Poder "
            "Executivo Federal e do Governo do Distrito Federal.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.serpro.sougov",
        icon: "assets/images/imgIconAppSouGovBr.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Pessoa Física",
        phone: "",
        explanation:
            "Aplicativo da Receita Federal para Pessoas Físicas com serviços, como "
            "consulta sobre o CPF, Restituição IRPF, cronograma de lotes para "
            "pagamento de restituição, e acompanhamento de Declaração.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.fazenda.receita.pessoafisica",
        icon: "assets/images/imgIconAppPessoaFisicaReceita.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "e-Título",
        phone: "",
        explanation:
            "App é a versão digital do título de eleitor. Nele é possível ter acesso "
            "à certidão de quitação eleitoral e de crimes eleitorais, "
            "bem como se cadastrar como mesário voluntário.",
        url:
            "https://play.google.com/store/apps/details?id=br.jus.tse.eleitoral.etitulo",
        icon: "assets/images/imgIconAppETitulo.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Meu INSS – Central de Serviços",
        phone: "",
        explanation:
            "O App possibilita dar entrada em um benefício ou serviço, bem como o "
            "acompanhamento do pedido. Você pode solicitar sua aposentadoria, "
            "calcular quanto tempo falta para se aposentar; solicitar declaração"
            " de recebimento de benefício do INSS, dentre outros serviços.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.dataprev.meuinss",
        icon: "assets/images/imgIconAppMeuINSS.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Conecte SUS",
        phone: "",
        explanation:
            "É o aplicativo oficial do Ministério da Saúde, no qual o cidadão "
            "brasileiro acompanha seu histórico no Sistema Único de Saúde (SUS), "
            "como exames, vacinas, dispensação de medicamentos e localização de "
            "estabelecimentos de saúde, dentre outros serviços.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.datasus.cnsdigital",
        icon: "assets/images/imgIconAppConecteSUS.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "Meu CadÚnico",
        phone: "",
        explanation:
            "O App possibilita a consulta das informações no Cadastro Único para "
            "Programas Sociais do Governo Federal.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.mds.cadastrounico",
        icon: "assets/images/imgIconAppMeuCadUnico.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "ID Jovem",
        phone: "",
        explanation:
            "O App possibilita aos jovens de baixa renda acesso a benefícios, como"
            "desconto em eventos artístico-culturais e esportivos; "
            "descontos em transporte interestadual; e gratuidade na emissão de "
            "Carteira de Identidade Estudantil.",
        url: "https://play.google.com/store/apps/details?id=com.idjovem2",
        icon: "assets/images/imgIconAppIdJovem.png",
        institutionType: InstitutionType.app),

    Institution(
        short: "",
        name: "ENEM",
        phone: "",
        explanation:
            "Pelo App é possível visualizar o cronograma da prova, acompanhar sua "
            "inscrição, acompanhar pedido de isenção de taxa de inscrição, "
            "ter acesso aos avisos e às notícias, dentre outros serviços.",
        url:
            "https://play.google.com/store/apps/details?id=br.gov.inep.inepenem",
        icon: "assets/images/imgIconAppENEM.png",
        institutionType: InstitutionType.app),

    //FIM----APPS-----------------------------------------------------------------
  ];
//_TODO_15/08/2021 (DADOS): Verificar a consistência das informações sobre as instituições, a melhor ordem, e se há mais alguma a ser inserida,
//TODO (UX): Incluir os caracteres de quebra de linha, indentação e formatação para cada texto da explicação.,

}
