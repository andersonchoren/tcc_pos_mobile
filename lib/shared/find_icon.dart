String findIcon(String discipline) {
  switch (discipline) {
    case 'Física':
      return 'physic';
    case 'Geografia':
      return 'geography';
    case 'Matemática':
      return 'math';
    case 'Português':
      return 'portuguese';
    case 'Química':
      return 'chemistry';
    case 'Música':
      return 'music';
    default:
      return 'book';
  }
}
