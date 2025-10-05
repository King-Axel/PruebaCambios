  Feature: Módulo de emergencias
    Esta característica esta relacionada al registro de pacientes en la sala de urgencias respetando su nivel de
    prioridad y el horario de llegada.

    Background:
      Given Que la siguiente enfermera esta registrada:
      |Nombre|Apellido|
      |Maria |Lopez   |

    Scenario: Ingreso del primer paciente a la lista de espera de urgencias
      Given que estan registrados los siguientes pacientes:
      |Cuil        |Apellido|Nombre|Obra Social|
      |12-3456789-0|Navarro |Axel  |Osde       |
      |22-1569874-2|Me bano |Jonatan|Swiss Medical|

      When ingresa a urgencias el siguiente paciente:
      |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
      |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |80                 |15                     |120/80             |

      Then la lista de espera de pacientes se ordena por cuil de la siguiente manera:
      |22-1569874-2|

    Scenario: Ingreso de un paciente de bajo nivel de emergencia y luego otro de alto nivel de emergencia
      Given que estan registrados los siguientes pacientes:
        |Cuil        |Apellido|Nombre|Obra Social|
        |12-3456789-0|Navarro |Axel  |Osde       |
        |22-1569874-2|Me bano |Jonatan|Swiss Medical|
        |26-2265455-5|Me lavo |Jony   |ASD          |

      When ingresa a urgencias el siguiente paciente:
        |Cuil         |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
        |22-1569884-2|Le duele el  pie          |Sin Urgencia       |37         |80                 |15                     |120/80             |
        |22-1569874-2|Tuvo un accidente de moto |Critica             |37         |80                 |15                     |120/80             |

      Then la lista de espera de pacientes se ordena por cuil de la siguiente manera:
        |22-1569874-2|
        |22-1569884-2|

    Scenario: Ingreso de un paciente de alto nivel de emergencia y luego otro de bajo nivel de emergencia
       Given que estan registrados los siguientes pacientes:
         |Cuil        |Apellido|Nombre|Obra Social|
         |12-3456789-0|Navarro |Axel  |Osde       |
         |22-1569874-2|Me bano |Jonatan|Swiss Medical|
         |26-2265455-5|Me lavo |Jony   |ASD          |

       When ingresa a urgencias el siguiente paciente:
         |Cuil        |      Informe             |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
         |22-1569884-2|Le duele el  pie          |Critica            |37         |80                 |15                     |120/80             |
         |22-1569874-2|Tuvo un accidente de moto |Sin Urgencia       |37         |80                 |15                     |120/80             |

       Then la lista de espera de pacientes se ordena por cuil de la siguiente manera:
         |22-1569884-2|
         |22-1569874-2|

    Scenario: Ingreso de un paciente del mismo nivel de prioridad que uno ya ingresado
       Given que estan registrados los siguientes pacientes:
         |Cuil        |Apellido|Nombre|Obra Social|
         |12-3456789-0|Navarro |Axel  |Osde       |
         |22-1569874-2|Me bano |Jonatan|Swiss Medical|
         |26-2265455-5|Me lavo |Jony   |ASD          |

       When ingresa a urgencias el siguiente paciente:
         |Cuil         |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial  | FechaHora           |
         |22-1569884-2 |Le duele el  pie         |Critica            |37         |80                 |15                     |120/80             | 2025-10-10 23:51:02 |
         |22-1569874-2 |Tuvo un accidente de moto|Critica            |37         |80                 |15                     |120/80             | 2025-10-10 23:30:39 |

       # La lista se ordena de arriba para abajo.
       Then la lista de espera de pacientes se ordena por cuil de la siguiente manera:
        |22-1569874-2 |
        |22-1569884-2 |

    Scenario: Ingreso de un paciente valores de frecuencia cardiaca negativos
       Given que estan registrados los siguientes pacientes:
         |Cuil        |Apellido|Nombre|Obra Social|
         |12-3456789-0|Navarro |Axel  |Osde       |
         |22-1569874-2|Me bano |Jonatan|Swiss Medical|

       When ingresa a urgencias el siguiente paciente:
         |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
         |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |-80                |15                     |120/80             |

       Then la enfermera modifica la frecuencia cardiaca
         |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
         |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |80                |15                     |120/80             |

    Scenario: Ingreso de un paciente valores de frecuencia respiratoria negativos
        Given que estan registrados los siguientes pacientes:
          |Cuil        |Apellido|Nombre|Obra Social|
          |12-3456789-0|Navarro |Axel  |Osde       |
          |22-1569874-2|Me bano |Jonatan|Swiss Medical|

        When ingresa a urgencias el siguiente paciente:
          |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
          |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |-80                |-15                    |120/80             |

        Then la enfermera modifica la frecuencia cardiaca
          |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
          |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |80                |15                     |120/80             |

    Scenario: Ingreso de un paciente con datos incompletos
      Given que estan registrados los siguientes pacientes:
        |Cuil        |Apellido|Nombre|Obra Social|
        |12-3456789-0|Navarro |Axel  |Osde       |
        |22-1569874-2|Me bano |Jonatan|Swiss Medical|

      When ingresa a urgencias el siguiente paciente:
        |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
        |22-1569874-2|                         |Critica            |37         |-80                |15                     |120/80            |

      Then la enfermera ingresa los datos omitidos:
        |Cuil        |      Informe            |Nivel de Emergencia|Temperatura|Frecuencia Cardiaca|Frecuencia Respiratoria| Tension Arterial |
        |22-1569874-2|Tuvo un accidente de moto|Critica            |37         |80                |15                     |120/80             |

    Scenario: Ingresa un paciente no existente
      When quiere ingresar al paciente "Milagros Berrondo"
      And no esta registrada

      Then registra los datos del paciente










