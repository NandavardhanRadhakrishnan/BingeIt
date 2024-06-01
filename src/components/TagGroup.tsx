interface Props {
  tags: string[];
}

function TagGroup({ tags }: Props) {
  return (
    <>
      {tags.map((tag, index) => (
        <span key={index} className="badge badge-pill badge-dark mr-1 ">
          {tag}
        </span>
      ))}
    </>
  );
}

export default TagGroup;
