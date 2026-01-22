import { VSOOrganization } from '@/types';

export const VSO_ORGANIZATIONS: Omit<VSOOrganization, 'id' | 'created_at'>[] = [
  {
    name: 'Disabled American Veterans',
    abbreviation: 'DAV',
    description:
      'The DAV provides free, professional assistance to veterans and their families in obtaining benefits and services earned through military service. With a nationwide network of service officers, DAV helps veterans file claims, gather evidence, and navigate the VA system.',
    website_url: 'https://www.dav.org',
    logo_url: undefined,
  },
  {
    name: 'The American Legion',
    abbreviation: 'TAL',
    description:
      'The American Legion is the nation\'s largest wartime veterans service organization, committed to mentoring youth and sponsorship of wholesome programs in communities, advocating patriotism and honor, promoting strong national security, and continued devotion to fellow servicemembers and veterans.',
    website_url: 'https://www.legion.org',
    logo_url: undefined,
  },
  {
    name: 'Veterans of Foreign Wars',
    abbreviation: 'VFW',
    description:
      'The VFW is dedicated to ensuring that veterans are respected for their service, always receive their earned entitlements, and are recognized for the sacrifices they and their loved ones have made on behalf of this great country. VFW provides claims assistance and representation.',
    website_url: 'https://www.vfw.org',
    logo_url: undefined,
  },
  {
    name: 'American Veterans',
    abbreviation: 'AMVETS',
    description:
      'AMVETS has been helping veterans since 1944, providing support for veterans and their families through service programs, legislative advocacy, and community outreach. They offer free assistance with VA claims and benefits.',
    website_url: 'https://www.amvets.org',
    logo_url: undefined,
  },
  {
    name: 'Vietnam Veterans of America',
    abbreviation: 'VVA',
    description:
      'Vietnam Veterans of America is the only national Vietnam veterans organization chartered by Congress. VVA is dedicated to the needs of Vietnam-era veterans and their families, offering claims assistance and advocacy.',
    website_url: 'https://vva.org',
    logo_url: undefined,
  },
  {
    name: 'Paralyzed Veterans of America',
    abbreviation: 'PVA',
    description:
      'PVA is the only congressionally chartered veterans service organization dedicated solely to the benefit and representation of veterans with spinal cord injury or disease. They provide free claims assistance and advocacy.',
    website_url: 'https://www.pva.org',
    logo_url: undefined,
  },
];

export const getVSOByAbbreviation = (abbreviation: string) => {
  return VSO_ORGANIZATIONS.find((vso) => vso.abbreviation === abbreviation);
};

export const getVSOByName = (name: string) => {
  return VSO_ORGANIZATIONS.find((vso) => vso.name === name);
};
