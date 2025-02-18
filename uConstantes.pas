unit uConstantes;

interface

type
  TRecGrupo = record
    Grupo: Integer;
    Bicho: string;
    Dezenas: array[1..4] of Integer;
  end;

const
  Grupos: Array[1..25] of TRecGrupo = (
    (Grupo: 1; Bicho: 'Avestruz'; Dezenas: (01, 02, 03, 04)),
    (Grupo: 2; Bicho: 'Águia'; Dezenas: (05, 06, 07, 08)),
    (Grupo: 3; Bicho: 'Burro'; Dezenas: (09, 10, 11, 12)),
    (Grupo: 4; Bicho: 'Borboleta'; Dezenas: (13, 14, 15, 16)),
    (Grupo: 5; Bicho: 'Cachorro'; Dezenas: (17, 18, 19, 20)),
    (Grupo: 6; Bicho: 'Cabra'; Dezenas: (21, 22, 23, 24)),
    (Grupo: 7; Bicho: 'Carneiro'; Dezenas: (25, 26, 27, 28)),
    (Grupo: 8; Bicho: 'Camelo'; Dezenas: (29, 30, 31, 32)),
    (Grupo: 9; Bicho: 'Cobra'; Dezenas: (33, 34, 35, 36)),
    (Grupo: 10; Bicho: 'Coelho'; Dezenas: (37, 38, 39, 40)),
    (Grupo: 11; Bicho: 'Cavalo'; Dezenas: (41, 42, 43, 44)),
    (Grupo: 12; Bicho: 'Elefante'; Dezenas: (45, 46, 47, 48)),
    (Grupo: 13; Bicho: 'Galo'; Dezenas: (49, 50, 51, 52)),
    (Grupo: 14; Bicho: 'Gato'; Dezenas: (53, 54, 55, 56)),
    (Grupo: 15; Bicho: 'Jacaré'; Dezenas: (57, 58, 59, 60)),
    (Grupo: 16; Bicho: 'Leão'; Dezenas: (61, 62, 63, 64)),
    (Grupo: 17; Bicho: 'Macaco'; Dezenas: (65, 66, 67, 68)),
    (Grupo: 18; Bicho: 'Porco'; Dezenas: (69, 70, 71, 72)),
    (Grupo: 19; Bicho: 'Pavão'; Dezenas: (73, 74, 75, 76)),
    (Grupo: 20; Bicho: 'Peru'; Dezenas: (77, 78, 79, 80)),
    (Grupo: 21; Bicho: 'Touro'; Dezenas: (81, 82, 83, 84)),
    (Grupo: 22; Bicho: 'Tigre'; Dezenas: (85, 86, 87, 88)),
    (Grupo: 23; Bicho: 'Urso'; Dezenas: (89, 90, 91, 92)),
    (Grupo: 24; Bicho: 'Veado'; Dezenas: (93, 94, 95, 96)),
    (Grupo: 25; Bicho: 'Vaca'; Dezenas: (97, 98, 99, 00))
  );


implementation

end.
