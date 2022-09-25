String? validateContentName(String value) {
  return value.isEmpty ? "O nome do conteúdo não pode ficar vazio" : null;
}

String? validateDisciplineName(String value) {
  return value.isEmpty ? "O nome da disciplina não pode ficar vazio" : null;
}
