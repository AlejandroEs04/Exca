import { toast } from "react-toastify";

export interface ValidationError {
  type: string;
  loc: (string | number)[];
  msg: string;
  input: any;
  ctx?: Record<string, any>;
}

export interface FormattedError {
  field: string;
  message: string;
}

export function isNullOrEmpty(value: string | number) : boolean {
    if( value === null || value === undefined || value === '') {
        return true;
    }

    return false;
}

export const currencyFormat = (amount : number) => {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
}

export const dateFormat = (date: string) => {
    const newDate = new Date(date);

    const options: Intl.DateTimeFormatOptions = {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: 'numeric',
        minute: '2-digit',
        hour12: true
    };

    const prettyFormat = newDate.toLocaleString('es-ES', options);
    return prettyFormat
}

export const isInputHelper = (target: EventTarget): target is HTMLInputElement => {
    return (target as HTMLInputElement).checked !== undefined;
};
export const formatToCurrency = (value: string | number): string => {
    const num = typeof value === 'number' ? value : parseFloat(String(value).replace(/[^0-9.]/g, ''))
    if (isNaN(num)) return ''
    return new Intl.NumberFormat('es-MX', {
        style: 'currency',
        currency: 'MXN',
        minimumFractionDigits: 2,
    }).format(num)
}

export function formatValidationErrors(errors: ValidationError[]): FormattedError[] {
    return errors.map(error => {
        const fieldPath = error.loc.slice(1); // Eliminamos 'body' del inicio
        const fieldName = fieldPath.join('.');

        return {
        field: fieldName,
        message: error.msg
        };
    });
}

export function handleError(error: unknown, options?: {
    defaultMessage?: string;
    validationMap?: Record<string, string>;
}): void {
    const defaultMessage = options?.defaultMessage || "An unexpected error occurred";
    const validationMap = options?.validationMap || {};

    console.error("Error:", error);

    if (typeof error === 'string') {
        toast.error(error);
        return;
    }

    if (error instanceof Error) {
        try {
            const parsedErrors = JSON.parse(error.message);
            
            if (Array.isArray(parsedErrors)) {
                parsedErrors.forEach((err: FormattedError) => {
                    const fieldName = validationMap[err.field] || err.field;
                    toast.error(`${fieldName}: ${err.message}`);
                });
                return;
            }
        } catch {
            toast.error(error.message || defaultMessage);
        }
        return;
    }

    toast.error(defaultMessage);
}