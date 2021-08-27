annotation Memoize
end

class Object
  macro inherited
    macro method_added(method)
      \{% if method.annotation(Memoize) %}
        memoize(\{{ method }})
      \{% end %}
    end
  end
end
