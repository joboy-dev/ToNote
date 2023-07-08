// BASE URL
String baseUrl = 'https://todoey-ji21.onrender.com';

// User Endpoints
final registerEndpoint = '$baseUrl/user/register/';
final loginEndpoint = '$baseUrl/user/login/';
final logoutEndpoint = '$baseUrl/user/logout/';
final userDetailsEndpoint = '$baseUrl/user/update/';
final getUploadPictureEndpoint = '$baseUrl/user/uploadPicture/';
final changePasswordEndpoint = '$baseUrl/user/changePassword/';

// Todo endpoints
final userTodosEndpoint = '$baseUrl/todo/list/';
final createTodoEndpoint = '$baseUrl/todo/list/create/';
// this needs a todo id!!
final todoDetailEndpoint = '$baseUrl/todo/list';
getTodoDetailEndpoint(int id) => '$baseUrl/todo/list/$id/';

// Note endpoints
final userNotesEndpoint = '$baseUrl/notes/list/';
final createNoteEndpoint = '$baseUrl/notes/create/';
// this needs a note id!!
final noteDetailEndpoint = '$baseUrl/notes/list';
getNoteDetailEndpoint(int id) => '$baseUrl/notes/list/$id/';

