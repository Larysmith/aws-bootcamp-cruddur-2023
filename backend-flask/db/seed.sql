-- this file was manually created (because we might auto generate it in future)
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('lary smith','ayinla.olanrewaju@gmail.com' , 'lary' ,'09c6edb6-0ef9-41ae-90a7-fd0550b9e17a'),
  ('azeez yusuf','olanrewaju_yusuf@yahoo.com' , 'azeezmock' ,'MOCK'),
  ('mirah yusuf','my@test.pro' , 'mirahmock' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'larymock' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )
