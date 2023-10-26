abstract class Mapper<E, M> {
  E fromModel(M model);
  M toModel(E entity);
}
