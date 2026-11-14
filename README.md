# Perez-post1-u8
@'
# Arquitectura de Computadores · Unidad 8: Operaciones con Cadenas y Aritmética Avanzada en NASM sobre DOSBox

Este repositorio contiene el desarrollo completo del laboratorio práctico correspondiente a la **Unidad 8**, implementado en lenguaje ensamblador **x86 de 16 bits (NASM)** bajo el entorno emulado **DOSBox 0.74-3**. El proyecto se divide en dos partes complementarias: el procesamiento de cadenas en memoria mediante instrucciones especializadas y la ejecución de operaciones aritméticas de precisión múltiple y decimal codificado en binario (BCD).

---

## Estructura del Repositorio

```text
perez-post1-u8/
├── parte1/
│   ├── post1.asm / post1.com     # Copia de cadenas con REP MOVSB y optimización con REP MOVSW
│   ├── post1c.asm / post1c.com   # Búsqueda de caracteres en cadena mediante REPNE SCASB
│   ├── post1d.asm / post1d.com   # Comparación lexicográfica de cadenas con REPE CMPSB
│   └── post1e.asm / post1e.com   # Copia con transformación a mayúsculas usando LODSB y STOSB
├── parte2/
│   ├── post2.asm / post2.com     # Suma y resta de enteros de 32 bits con ADC y SBB
│   ├── post2b.asm / post2b.com   # Ajuste aritmético BCD empaquetado mediante DAA y DAS
│   ├── post2c.asm / post2c.com   # Mini calculadora de enteros (MUL/DIV) con conversión ASCII
│   └── post2d.asm / post2d.com   # Ajuste aritmético BCD desempaquetado con AAA y AAS
├── capturas/                     # Evidencias gráficas de compilación y ejecución en DOSBox
└── README.md                     # Documentación técnica y decisiones justificadas
