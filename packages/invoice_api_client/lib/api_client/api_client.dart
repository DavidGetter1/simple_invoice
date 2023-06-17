abstract class ApiClient<T> {
  delete(String id);
  getById(String id);
  get(Map<String, String> query);
  insert(T data);
  update(T data);
}
