-- Creates get_my_role() — called by the frontend AuthContext to resolve
-- the current user's role without exposing user_id in the query.
-- SECURITY DEFINER bypasses RLS so it always works even before RLS is set up.
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS text
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT role::text
  FROM public.user_roles
  WHERE user_id = auth.uid()
  LIMIT 1;
$$;

GRANT EXECUTE ON FUNCTION public.get_my_role() TO authenticated, anon;
